defmodule Customerio.Error do
  defexception reason: "undefined error"

  @type t :: %Customerio.Error{reason: any}
  def message(%{reason: reason}), do: inspect reason
end

defmodule Customerio.Success do
  @doc """
  Test
  """
  defstruct [:response]

  @type t :: %Customerio.Success{response: %HTTPoison.Response{}}
end
