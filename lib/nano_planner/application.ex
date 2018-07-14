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

    # Connect to the master from slave nodes.
    if System.get_env("MASTER") != "1" do
      Node.connect(:foo@oiax)
    end

    # See https://hexdocs.pm/elixir/Supervisor.html
    # for other strategies and supported options
    opts = [strategy: :one_for_one, name: NanoPlanner.Supervisor]
    Supervisor.start_link(children, opts)
  end

  # Tell Phoenix to update the endpoint configuration
  # whenever the application is updated.
  def config_change(changed, _new, removed) do
    NanoPlannerWeb.Endpoint.config_change(changed, removed)
    :ok
  end
end
