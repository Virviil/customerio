defmodule Customerio do
  import Customerio.Util

  @type value :: number | String.t | atom()

  @spec identify(id :: number | binary, data_map :: %{}, opts :: keyword(value)) :: :ok
  def identify(id, data_map, opts \\ []) do
    send_request(
      :put,
      "customers/#{URI.encode(id |> to_string)}",
      data_map,
      opts
    )
  end

  def identify!(id, data_map, opts \\ []) do
    case identify(id, data_map, opts) do
      {:ok, s = %Customerio.Success{} } -> s
      {:error, e} -> raise e
    end
  end

  def delete(id, opts \\ []) do
    send_request(
      :delete,
      "customers/#{URI.encode(id |> to_string)}",
      %{},
      opts
    )
  end

  def delete!(id, opts \\ []) do
    case delete(id, opts) do
      {:ok, s = %Customerio.Success{}} -> s
      {:error, e} -> raise e
    end
  end

  def track(id, name, data_map, opts \\ []) do
    send_request(
      :post,
      "customers/#{URI.encode(id |> to_string)}/events",
      %{name: name, data: data_map},
      opts
    )
  end

  def track!(id, name, data_map, opts \\ []) do
    case track(id, name, data_map, opts) do
      {:ok, s = %Customerio.Success{}} -> s
      {:error, e} -> raise e
    end
  end


  def anonymous_track(name, data_map, opts \\ []) do
    send_request(
      :post,
      "events",
      %{name: name, data: data_map},
      opts
    )
  end

  def anonymous_track!(name, data_map, opts \\ []) do
    case anonymous_track(name, data_map, opts) do
      {:ok, s = %Customerio.Success{}} -> s
      {:error, e} -> raise e
    end
  end

  def track_page_view(id, page_name, data_map, opts \\ []) do
    send_request(
      :post,
      "customers/#{URI.encode(id |> to_string)}/events",
      %{name: page_name, type: "page", data: data_map},
      opts
    )
  end

  def track_page_view!(id, page_name, data_map, opts \\ []) do
    case track_page_view(id, page_name, data_map, opts) do
      {:ok, s = %Customerio.Success{}} -> s
      {:error, e} -> raise e
    end
  end
end
