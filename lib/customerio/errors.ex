defmodule Customerio.Error do
  defexception reason: "undefined error"

  def message(%{reason: reason}), do: inspect reason
end

defmodule Customerio.Success do
  @doc """
  Test
  """
  defstruct [:response]
end
