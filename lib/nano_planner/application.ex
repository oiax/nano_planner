require Logger

defmodule NanoPlanner.Application do
  use Application

  # See https://hexdocs.pm/elixir/Application.html
  # for more information on OTP Applications
  def start(_type, _args) do
    import Supervisor.Spec

    # Define workers and child supervisors to be supervised
    children = [
      # Start the Ecto repository
      supervisor(NanoPlanner.Repo, []),
      # Start the endpoint when the application starts
      supervisor(NanoPlannerWeb.Endpoint, [])
    ]

    # Start the counter on master node.
    children =
      case System.get_env("MASTER") do
        "1" -> [{Counter.Agent, []} | children]
        _ -> children
      end

    # Get the ip address of this node.
    {:ok, ifs} = :inet.getif()
    ips = Enum.map(ifs, fn {ip, _, _} -> ip end)
    ip0 = Enum.find(ips, fn(ip) -> elem(ip, 0) == 192 end)

    # Connect to peer nodes.
    tasks = Enum.map(101..105, fn(n) ->
      node_name = :"np@192.168.56.#{n}"
      case elem(ip0, 3) do
        ^n -> Task.async(fn -> Logger.info("Skipping #{node_name}.") end)
        _ -> Task.async(fn -> connect_to_peer(node_name) end)
      end
    end)

    for task <- tasks, do: Task.await(task, 10000)

    # See https://hexdocs.pm/elixir/Supervisor.html
    # for other strategies and supported options
    opts = [strategy: :one_for_one, name: NanoPlanner.Supervisor]
    Supervisor.start_link(children, opts)
  end

  defp connect_to_peer(node_name) do
    case Node.connect(node_name) do
      true -> Logger.info("Connected to #{node_name}.")
      false -> Logger.info("Rejected by #{node_name}.")
      :ignored -> Logger.info("Ignorned by #{node_name}.")
    end
  end

  # Tell Phoenix to update the endpoint configuration
  # whenever the application is updated.
  def config_change(changed, _new, removed) do
    NanoPlannerWeb.Endpoint.config_change(changed, removed)
    :ok
  end
end
