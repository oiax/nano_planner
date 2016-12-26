defmodule NanoPlanner.TopView do
  use NanoPlanner.Web, :view
  use Xain, except: [link: 2]

  def xyz do
    markup do
      for x <- ~W(A B) do
        span x
        text "T"
      end
    end
  end
end
