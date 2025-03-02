defmodule ElixirMockTestDemoWeb.MockCase do
  use ExUnit.CaseTemplate

  using do
    quote do
      import Hammox
      setup :verify_on_exit!
    end
  end
end
