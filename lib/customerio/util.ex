defmodule Customerio.Util do
  @moduledoc false
  @type value :: number | String.t() | atom()

  @behavioral_base_route "https://track.customer.io/api/v1/"

  @api_base_route "https://api.customer.io/v1/api"

  defp get_username, do: Application.get_env(:customerio, :site_id)
  defp get_password, do: Application.get_env(:customerio, :api_key)

  defp with_auth(opts) do
    Keyword.merge([basic_auth: {get_username(), get_password()}], opts)
  end

  defp put_headers do
    [{"Content-Type", "application/json"}]
  end

  @typedoc """
  Available HTTP methods
  """
  @type method :: :get | :post | :delete | :put | :patch

  def send_behavioral_request(method, route, data_map, opts \\ []) do
    send_request(method, @behavioral_base_route <> route, data_map, opts)
  end

  def send_api_request(method, route, data_map, opts \\ []) do
    send_request(method, @api_base_route <> route, data_map, opts)
  end

  @doc """
  This method sends requests to `customer.io` API endpoint, with
  defined method, route, body and HTTPoison options.
  """
  @spec send_request(
          method :: method,
          route :: String.t(),
          data_map :: map(),
          opts :: Keyword.t()
        ) :: {:ok, String.t()} | {:error, Customerio.Error.t()}
  def send_request(method, route, data_map, opts \\ []) do
    :hackney.request(
      method,
      route,
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
