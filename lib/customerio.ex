defmodule Customerio do
  import Customerio.Util

  @type value :: number | String.t | atom()

  @doc """
  Creating or updating customers.

  ## Params

    * `id` - the unique identifier for the customer.

    * `data_map` - custom attributes to define the customer.

    * `opts` - HTTPoison options.

  ## Example

  ```elixir
  iex> Customerio.identify(5, %{email: "success@example.com"})
  {:ok, %Customerio.Success{}}
  iex> Customerio.identify(6, %{email: "fail@example.com"})
  {:error, %Customerio.Error{}}
  ```
  """
  @spec identify(
    id :: value,
    data_map :: %{key: value},
    opts :: [key: value]) :: {:ok, Customerio.Success.t} | {:error, Customerio.Error.t}
  def identify(id, data_map, opts \\ []) do
    send_request(
      :put,
      "customers/#{URI.encode(id |> to_string)}",
      data_map,
      opts
    )
  end

  @doc """
  Creating or updating customers.

  Raises `Customerio.Error` if fails.

  ## Params

    * `id` - the unique identifier for the customer.

    * `data_map` - custom attributes to define the customer.

    * `opts` - HTTPoison options.

  ## Example

  ```elixir
  iex> Customerio.identify!(5, %{email: "success@example.com"})
  %Customerio.Success{}
  iex> Customerio.identify!(6, %{email: "fail@example.com"})
  ** (Customerio.Error) "Epic fail!"
  ```
  """
  @spec identify!(
    id :: value,
    data_map :: %{key: value},
    opts :: [key: value]) :: Customerio.Success.t
  def identify!(id, data_map, opts \\ []) do
    case identify(id, data_map, opts) do
      {:ok, s = %Customerio.Success{} } -> s
      {:error, e} -> raise e
    end
  end

  @doc """
  Delete customers.

  ## Params

    * `id` - the unique identifier for the customer.

    * `opts` - HTTPoison options.

  ## Example

  ```elixir
  iex> Customerio.delete(5)
  {:ok, %Customerio.Success{}}
  iex> Customerio.delete(6)
  {:error, %Customerio.Error{}}
  ```
  """
  @spec delete(
    id :: value,
    opts :: [key: value]) :: {:ok, Customerio.Success.t} | {:error, Customerio.Error.t}
  def delete(id, opts \\ []) do
    send_request(
      :delete,
      "customers/#{URI.encode(id |> to_string)}",
      %{},
      opts
    )
  end


  @doc """
  Delete customers.

  Raises `Customerio.Error` if fails.

  ## Params

    * `id` - the unique identifier for the customer.

    * `opts` - HTTPoison options.

  ## Example

  ```elixir
  iex> Customerio.delete!(5)
  %Customerio.Success{}
  iex> Customerio.delete!(6)
  ** (Customerio.Error) "Epic fail!"
  ```
  """
  @spec delete!(
    id :: value,
    opts :: [key: value]) :: Customerio.Success.t
  def delete!(id, opts \\ []) do
    case delete(id, opts) do
      {:ok, s = %Customerio.Success{}} -> s
      {:error, e} -> raise e
    end
  end


  @doc """
  Track the event for given customer.

  ## Params

    * `id` - the unique identifier for the customer.

    * `name` - the name of the event to track.

    * `data_map` - custom attributes to define the customer.

    * `opts` - HTTPoison options.

  ## Example

  ```elixir
  iex> Customerio.track(5, "purchase", %{price: 23,45})
  {:ok, %Customerio.Success{}}
  iex> Customerio.track(6, "crash", %{reason: "epic fail"})
  {:error, %Customerio.Error{}}
  ```
  """
  @spec track(
    id :: value,
    name :: value,
    data_map :: %{key: value},
    opts :: [key: value]) :: {:ok, Customerio.Success.t} | {:error, Customerio.Error.t}
  def track(id, name, data_map, opts \\ []) do
    send_request(
      :post,
      "customers/#{URI.encode(id |> to_string)}/events",
      %{name: name, data: data_map},
      opts
    )
  end

  @doc """
  Track the event for given customer.

  Raises `Customerio.Error` if fails.

  ## Params

    * `id` - the unique identifier for the customer.

    * `name` - the name of the event to track.

    * `data_map` - custom attributes to define the customer.

    * `opts` - HTTPoison options.

  ## Example

  ```elixir
  iex> Customerio.track!(5, "purchase", %{price: 23,45})
  %Customerio.Success{}
  iex> Customerio.track!(6, "crash", %{reason: "epic fail"})
  ** (Customerio.Error) "Epic fail!"
  ```
  """
  @spec track!(
    id :: value,
    name :: value,
    data_map :: %{key: value},
    opts :: [key: value]) :: Customerio.Success.t
  def track!(id, name, data_map, opts \\ []) do
    case track(id, name, data_map, opts) do
      {:ok, s = %Customerio.Success{}} -> s
      {:error, e} -> raise e
    end
  end

  @doc """
  Track anonymous events directly without customer ID.

  ## Params

    * `name` - the name of the event to track.

    * `data_map` - custom attributes to define the customer.

    * `opts` - HTTPoison options.

  ## Example

  ```elixir
  iex> Customerio.anonymous_track("purchase", %{recipient: "success@example.com"})
  {:ok, %Customerio.Success{}}
  iex> Customerio.anonymous_track("purchase", %{recipient: "fail@example.com"})
  {:error, %Customerio.Error{}}
  ```
  """
  @spec anonymous_track(
    name :: value,
    data_map :: %{key: value},
    opts :: [key: value]) :: {:ok, Customerio.Success.t} | {:error, Customerio.Error.t}
  def anonymous_track(name, data_map, opts \\ []) do
    send_request(
      :post,
      "events",
      %{name: name, data: data_map},
      opts
    )
  end

  @doc """
  Track anonymous events directly without customer ID.

  Raises `Customerio.Error` if fails.

  ## Params

    * `name` - the name of the event to track.

    * `data_map` - custom attributes to define the customer.

    * `opts` - HTTPoison options.

  ## Example

  ```elixir
  iex> Customerio.anonymous_track!("purchase", %{recipient: "success@example.com"})
  %Customerio.Success{}
  iex> Customerio.anonymous_track!("purchase", %{recipient: "fail@example.com"})
  ** (Customerio.Error) "Epic fail!"
  ```
  """
  @spec anonymous_track!(
    name :: value,
    data_map :: %{key: value},
    opts :: [key: value]) :: Customerio.Success.t
  def anonymous_track!(name, data_map, opts \\ []) do
    case anonymous_track(name, data_map, opts) do
      {:ok, s = %Customerio.Success{}} -> s
      {:error, e} -> raise e
    end
  end


  @doc """
  Track page view event directly with customer ID.

  ## Params

    * `id` - the unique identifier for the customer.

    * `page_name` - the URL of the page.

    * `data_map` - custom attributes to define the customer.

    * `opts` - HTTPoison options.

  ## Example

  ```elixir
  iex> Customerio.track_page_view(5, "http://google.com", %{ref: "success"})
  {:ok, %Customerio.Success{}}
  iex> Customerio.track_page_view(5, "http://google.com", %{ref: "fail"})
  {:error, %Customerio.Error{}}
  ```
  """
  @spec track_page_view(
    id :: value,
    page_name :: String.t,
    data_map :: %{key: value},
    opts :: [key: value]) :: {:ok, Customerio.Success.t} | {:error, Customerio.Error.t}
  def track_page_view(id, page_name, data_map, opts \\ []) do
    send_request(
      :post,
      "customers/#{URI.encode(id |> to_string)}/events",
      %{name: page_name, type: "page", data: data_map},
      opts
    )
  end

  @doc """
  Track page view event directly with customer ID.

  Raises `Customerio.Error` if fails.

  ## Params

    * `id` - the unique identifier for the customer.

    * `page_name` - the URL of the page.

    * `data_map` - custom attributes to define the customer.

    * `opts` - HTTPoison options.

  ## Example

  ```elixir
  iex> Customerio.track_page_view!(5, "http://google.com", %{ref: "success"})
  %Customerio.Success{}
  iex> Customerio.track_page_view!(5, "http://google.com", %{ref: "fail"})
  ** (Customerio.Error) "Epic fail!"
  ```
  """
  @spec track_page_view!(
    id :: value,
    page_name :: value,
    data_map :: %{key: value},
    opts :: [key: value]) :: Customerio.Success.t | {:error, Customerio.Error.t}
  def track_page_view!(id, page_name, data_map, opts \\ []) do
    case track_page_view(id, page_name, data_map, opts) do
      {:ok, s = %Customerio.Success{}} -> s
      {:error, e} -> raise e
    end
  end
end
