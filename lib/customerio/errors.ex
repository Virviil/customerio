defmodule Customerio.Error do
  @moduledoc """
  Customer.IO API error exeption
  """
  defexception reason: "undefined error",
               code: nil

  @typedoc """
  Customer.IO API error
  """
  @type t :: %Customerio.Error{reason: any, code: integer() | nil}

  @doc nil
  def message(%{reason: reason}), do: inspect(reason)
end
