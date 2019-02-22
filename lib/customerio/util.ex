defmodule Customerio.Util do
  @moduledoc false
  @type value :: number | String.t() | atom()

  @base_route "https://track.customer.io/api/v1/"

  defp get_username, do: Application.get_env(:customerio, :site_id)
  defp get_password, do: Application.get_env(:customerio, :api_key)

  defp with_auth(opts) do
    Keyword.put(
      opts,
      :hackney,
      basic_auth: {
        get_username(),
        get_password()
      }
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
          route :: String.t(),
          data_map :: map(),
          opts :: Keyword.t()
        ) :: {:ok, String.t()} | {:error, Customerio.Error.t()}
  def send_request(method, route, data_map, opts \\ []) do
    :hackney.request(
      method,
      @base_route <> route,
      put_headers(),
      data_map |> Jason.encode!(),
      with_auth(opts)
    )
  else
    {:ok, 200, _, client_ref} ->
      case :hackney.body(client_ref) do
        {:ok, data} -> {:ok, data}
        _ -> {:error, %Customerio.Error{reason: "hackney internal error"}}
      end

    {:ok, status_code, _, client_ref} ->
      {:error, %Customerio.Error{code: status_code, reason: elem(:hackney.body(client_ref), 1)}}

    {:error, reason} ->
      {:error, %Customerio.Error{reason: reason}}
  end
end
