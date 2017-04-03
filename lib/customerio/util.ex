defmodule Customerio.Util do
  @moduledoc """
  Collection of utilites for this library.
  You should not use it in your code.
  """
  @base_route "https://track.customer.io/api/v1/"

  defp get_username, do: Application.get_env(:customerio, :site_id)
  defp get_password, do: Application.get_env(:customerio, :api_key)

  defp put_auth(opts) do
    opts
    |> Keyword.put(
      :hackney, [
        basic_auth: {
          get_username(),
          get_password()
        }
      ]
    )
  end

  defp put_headers do
    [{"Content-Type", "application/json"}]
  end

  @doc """
  This method sends requests to `customer.io` API endpoint, with
  defined method, route, body and HTTPoison options.
  """

  @type method :: :get | :post | :delete | :put | :patch
  @spec send_request(
    method :: method,
    route :: String.t,
    data_map :: %{},
    opts :: []) :: any
  def send_request(method, route, data_map, opts \\ []) do
    case HTTPoison.request(
      method,
      @base_route <> route,
      data_map |> Poison.encode!,
      put_headers(),
      opts |> put_auth
    ) do
      {:ok, response = %HTTPoison.Response{status_code: 200}} -> {:ok, %Customerio.Success{response: response}}
      {:ok, response} -> {:error, %Customerio.Error{reason: response}}
      {:error, reason} -> {:error, %Customerio.Error{reason: reason}}
    end
  end
end
