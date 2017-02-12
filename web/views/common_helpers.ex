defmodule NanoPlanner.CommonHelpers do
  defmacro __using__(_) do
    quote do
      def document_title(_assigns) do
        "NanoPlanner"
      end

      defoverridable [document_title: 1]
    end
  end
end
