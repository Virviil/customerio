defmodule Customerio.Error do
  defexception reason: "undefined error",
               code: nil

  @type t :: %Customerio.Error{reason: any, code: integer() | nil}
  def message(%{reason: reason}), do: inspect(reason)
end
