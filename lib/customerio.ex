defmodule Customerio do
  @moduledoc """
  Main module to interact with API.
  """
  import Customerio.Util

  @typedoc """
  Represents fuzzy type that can be used to send data to Customer.IO
  """
  @type value :: number | String.t() | atom()

  @typedoc """
  Represents the type of an Customer.IO API answers
  """
  @type result :: String.t()

  @doc """
  Creating or updating customers.

  ## Params

    * `id` - the unique identifier for the customer.

    * `data_map` - custom attributes to define the customer.

    * `opts` - HTTPoison options.

  ## Example

  ```elixir
  iex> Customerio.identify(5, %{email: "success@example.com"})
  {:ok, "..."}
  iex> Customerio.identify(6, %{email: "fail@example.com"})
  {:error, %Customerio.Error{}}
  ```
  """
  @spec identify(
          id :: value,
          data_map :: %{key: value},
          opts :: [key: value]
        ) :: {:ok, result} | {:error, Customerio.Error.t()}
  def identify(id, data_map, opts \\ []) do
    send_behavioral_request(
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
  ".."
  iex> Customerio.identify!(6, %{email: "fail@example.com"})
  ** (Customerio.Error) "Epic fail!"
  ```
  """
  @spec identify!(
          id :: value,
          data_map :: %{key: value},
          opts :: Keyword.t()
        ) :: result | no_return()
  def identify!(id, data_map, opts \\ []) do
    case identify(id, data_map, opts) do
      {:ok, result} -> result
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
  {:ok, "..."}
  iex> Customerio.delete(6)
  {:error, %Customerio.Error{}}
  ```
  """
  @spec delete(
          id :: value,
          opts :: [key: value]
        ) :: {:ok, result} | {:error, Customerio.Error.t()}
  def delete(id, opts \\ []) do
    send_behavioral_request(
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
  ",,,"
  iex> Customerio.delete!(6)
  ** (Customerio.Error) "Epic fail!"
  ```
  """
  @spec delete!(
          id :: value,
          opts :: Keyword.t()
        ) :: result | no_return()
  def delete!(id, opts \\ []) do
    case delete(id, opts) do
      {:ok, result} -> result
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
  {:ok, "..."}
  iex> Customerio.track(6, "crash", %{reason: "epic fail"})
  {:error, %Customerio.Error{}}
  ```
  """
  @spec track(
          id :: value,
          name :: value,
          data_map :: %{key: value},
          opts :: Keyword.t()
        ) :: {:ok, result} | {:error, Customerio.Error.t()}
  def track(id, name, data_map, opts \\ []) do
    send_behavioral_request(
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
  "..."
  iex> Customerio.track!(6, "crash", %{reason: "epic fail"})
  ** (Customerio.Error) "Epic fail!"
  ```
  """
  @spec track!(
          id :: value,
          name :: value,
          data_map :: %{key: value},
          opts :: [key: value]
        ) :: result | no_return()
  def track!(id, name, data_map, opts \\ []) do
    case track(id, name, data_map, opts) do
      {:ok, result} -> result
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
  {:ok, "..."}
  iex> Customerio.anonymous_track("purchase", %{recipient: "fail@example.com"})
  {:error, %Customerio.Error{}}
  ```
  """
  @spec anonymous_track(
          name :: value,
          data_map :: %{key: value},
          opts :: [key: value]
        ) :: {:ok, result} | {:error, Customerio.Error.t()}
  def anonymous_track(name, data_map, opts \\ []) do
    send_behavioral_request(
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
  "..."
  iex> Customerio.anonymous_track!("purchase", %{recipient: "fail@example.com"})
  ** (Customerio.Error) "Epic fail!"
  ```
  """
  @spec anonymous_track!(
          name :: value,
          data_map :: %{key: value},
          opts :: [key: value]
        ) :: result | no_return()
  def anonymous_track!(name, data_map, opts \\ []) do
    case anonymous_track(name, data_map, opts) do
      {:ok, result} -> result
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
  {:ok, "..."}
  iex> Customerio.track_page_view(5, "http://google.com", %{ref: "fail"})
  {:error, %Customerio.Error{}}
  ```
  """
  @spec track_page_view(
          id :: value,
          page_name :: String.t(),
          data_map :: %{key: value},
          opts :: [key: value]
        ) :: {:ok, result} | {:error, Customerio.Error.t()}
  def track_page_view(id, page_name, data_map, opts \\ []) do
    send_behavioral_request(
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
  "..."
  iex> Customerio.track_page_view!(5, "http://google.com", %{ref: "fail"})
  ** (Customerio.Error) "Epic fail!"
  ```
  """
  @spec track_page_view!(
          id :: value,
          page_name :: value,
          data_map :: %{key: value},
          opts :: [key: value]
        ) :: result | no_return()
  def track_page_view!(id, page_name, data_map, opts \\ []) do
    case track_page_view(id, page_name, data_map, opts) do
      {:ok, result} -> result
      {:error, e} -> raise e
    end
  end

  #############################################################################
  ### Devices
  #############################################################################

  @doc """
  Create or update a customer device.

  ## Params

    * `id` - the unique identifier for the customer.

    * `device_id` - The unique token for the user device.

    * `platform` - The platform for the user device. Allowed values are 'ios' and 'android'.

    * `data_map` - custom attributes to define the request:

      * `last_used` - UNIX timestamp representing the last used time for the device.
        If this is not included we default to the time of the device identify.

    * `opts` - HTTPoison options.

  ## Example

  ```elixir
  iex> Customerio.add_device(5, "my_ios_device_id", "ios", %{last_used: 1514764800})
  {:ok, "..."}
  iex> Customerio.add_device(5, "my_ios_device_id", "epic_fail_devise")
  {:error, %Customerio.Error{}}
  ```
  """
  @spec add_device(
          id :: value,
          device_id :: value,
          platform :: value,
          data_map :: map(),
          opts :: Keyword.t()
        ) :: {:ok, result} | {:error, Customerio.Error.t()}
  def add_device(id, device_id, platfrom, data_map \\ %{}, opts \\ []) do
    send_behavioral_request(
      :put,
      "customers/#{URI.encode(id |> to_string)}/devices",
      %{device: Map.merge(%{id: device_id, platform: platfrom}, data_map)},
      opts
    )
  end

  @doc """
  Create or update a customer device.

  Raises `Customerio.Error` if fails.

  ## Params

    * `id` - the unique identifier for the customer.

    * `device_id` - The unique token for the user device.

    * `platform` - The platform for the user device. Allowed values are 'ios' and 'android'.

    * `data_map` - custom attributes to define the request:

      * `last_used` - UNIX timestamp representing the last used time for the device.
        If this is not included we default to the time of the device identify.

    * `opts` - HTTPoison options.

  ## Example

  ```elixir
  iex> Customerio.add_device(5, "my_ios_device_id", "ios", %{last_used: 1514764800})
  "..."
  iex> Customerio.add_device(5, "my_ios_device_id", "epic_fail_devise")
  ** (Customerio.Error) "Epic fail!"
  ```
  """
  @spec add_device!(
          id :: value,
          device_id :: value,
          platform :: value,
          data_map :: map(),
          opts :: Keyword.t()
        ) :: result | no_return()
  def add_device!(id, device_id, platfrom, data_map \\ %{}, opts \\ []) do
    add_device(id, device_id, platfrom, data_map, opts)
  else
    {:ok, result} -> result
    {:error, e} -> raise e
  end

  @doc """
  Delete a customer device.

  ## Params

    * `id` - the unique identifier for the customer.

    * `device_id` - the unique token for the user device.

    * `opts` - HTTPoison options.

  ## Example

  ```elixir
  iex> Customerio.delete_device(5, :my_device)
  {:ok, "..."}
  iex> Customerio.delete_device(6, :fail_device)
  {:error, %Customerio.Error{}}
  ```
  """
  @spec delete_device(
          id :: value,
          device_id :: value,
          opts :: Keyword.t()
        ) :: {:ok, result} | {:error, Customerio.Error.t()}
  def delete_device(id, device_id, opts \\ []) do
    send_behavioral_request(
      :delete,
      "customers/#{URI.encode(id |> to_string)}/devices/#{URI.encode(device_id |> to_string)}",
      %{},
      opts
    )
  end

  @doc """
  Delete a customer device.

  Raises `Customerio.Error` if fails.

  ## Params

    * `id` - the unique identifier for the customer.

    * `device_id` - the unique token for the user device.

    * `opts` - HTTPoison options.

  ## Example

  ```elixir
  iex> Customerio.delete_device!(5, :my_device)
  "..."
  iex> Customerio.delete_device!(6, :fail_device)
  ** (Customerio.Error) "Epic fail!"
  ```
  """
  @spec delete_device!(
          id :: value,
          device_id :: value,
          opts :: Keyword.t()
        ) :: result | no_return()
  def delete_device!(id, device_id, opts \\ []) do
    delete_device(id, device_id, opts)
  else
    {:ok, result} -> result
    {:error, e} -> raise e
  end

  #############################################################################
  ### Supressing
  #############################################################################

  @doc """
  Deletes the customer with the provided id
  if it exists and suppresses all future events
  and identifies for for that customer.

  ## Params

    * `id` - the unique identifier for the customer.

    * `opts` - HTTPoison options.

  ## Example

  ```elixir
  iex> Customerio.suppress(5)
  {:ok, "..."}
  iex> Customerio.suppress(6)
  {:error, %Customerio.Error{}}
  ```
  """
  @spec suppress(
          id :: value,
          opts :: Keyword.t()
        ) :: {:ok, result} | {:error, Customerio.Error.t()}
  def suppress(id, opts \\ []) do
    send_behavioral_request(
      :post,
      "customers/#{URI.encode(id |> to_string)}/suppress",
      %{},
      opts
    )
  end

  @doc """
  Deletes the customer with the provided id
  if it exists and suppresses all future events
  and identifies for for that customer.

  Raises `Customerio.Error` if fails.

  ## Params

    * `id` - the unique identifier for the customer.

    * `opts` - HTTPoison options.

  ## Example

  ```elixir
  iex> Customerio.suppress!(5)
  "..."
  iex> Customerio.suppress!(6)
  ** (Customerio.Error) "Epic fail!"
  ```
  """
  @spec suppress!(
          id :: value,
          opts :: Keyword.t()
        ) :: result | no_return()
  def suppress!(id, opts \\ []) do
    suppress(id, opts)
  else
    {:ok, result} -> result
    {:error, e} -> raise e
  end

  @doc """
  Start tracking events and identifies again
  for a previously suppressed customer.
  Note when a user is suppressed thier history is deleted
  and unsupressing them wil not recover that history.

  ## Params

    * `id` - the unique identifier for the customer.

    * `opts` - HTTPoison options.

  ## Example

  ```elixir
  iex> Customerio.unsuppress(5)
  {:ok, "..."}
  iex> Customerio.unsuppress(6)
  {:error, %Customerio.Error{}}
  ```
  """
  @spec unsuppress(
          id :: value,
          opts :: Keyword.t()
        ) :: {:ok, result} | {:error, Customerio.Error.t()}
  def unsuppress(id, opts \\ []) do
    send_behavioral_request(
      :post,
      "customers/#{URI.encode(id |> to_string)}/unsuppress",
      %{},
      opts
    )
  end

  @doc """
  Start tracking events and identifies again
  for a previously suppressed customer.
  Note when a user is suppressed thier history is deleted
  and unsupressing them wil not recover that history.

  Raises `Customerio.Error` if fails.

  ## Params

    * `id` - the unique identifier for the customer.

    * `opts` - HTTPoison options.

  ## Example

  ```elixir
  iex> Customerio.unsuppress!(5)
  "..."
  iex> Customerio.unsuppress!(6)
  ** (Customerio.Error) "Epic fail!"
  ```
  """
  @spec unsuppress!(
          id :: value,
          opts :: Keyword.t()
        ) :: result | no_return()
  def unsuppress!(id, opts \\ []) do
    unsuppress(id, opts)
  else
    {:ok, result} -> result
    {:error, e} -> raise e
  end

  #############################################################################
  ### Segments
  #############################################################################

  @doc """
  Add the list of customer ids to the specified manual segment.
  If you send customer ids that don't exist yet
  in an add_to_segment request, we will automatically
  create customer profiles for the new customer ids.

  ## Params

    * `id` - the unique identifier of the segment.

    * `ids` - a list of customer ids to add to the segment.

    * `opts` - HTTPoison options.

  ## Example

  ```elixir
  iex> Customerio.add_to_segment(1, [1, 2, 3])
  {:ok, "..."}
  iex> Customerio.add_to_segment(1000, [1, 2, 3])
  {:error, %Customerio.Error{}}
  ```
  """
  @spec add_to_segment(
          id :: value,
          ids :: list(value),
          opts :: Keyword.t()
        ) :: {:ok, result} | {:error, Customerio.Error.t()}
  def add_to_segment(id, ids, opts \\ []) do
    send_behavioral_request(
      :post,
      "segments/#{URI.encode(id |> to_string)}/add_customers",
      %{ids: ids},
      opts
    )
  end

  @doc """
  Add the list of customer ids to the specified manual segment.
  If you send customer ids that don't exist yet
  in an add_to_segment request, we will automatically
  create customer profiles for the new customer ids.

  Raises `Customerio.Error` if fails.

  ## Params

    * `id` - the unique identifier of the segment.

    * `ids` - a list of customer ids to add to the segment.

    * `opts` - HTTPoison options.

  ## Example

  ```elixir
  iex> Customerio.add_to_segment!(1, [1, 2, 3])
  "..."
  iex> Customerio.add_to_segment(1000, [1, 2, 3])
  ** (Customerio.Error) "Epic fail!"
  ```
  """
  @spec add_to_segment!(
          id :: value,
          ids :: list(value),
          opts :: Keyword.t()
        ) :: result | no_return()
  def add_to_segment!(id, ids, opts \\ []) do
    add_to_segment(id, ids, opts)
  else
    {:ok, result} -> result
    {:error, e} -> raise e
  end

  @doc """
  Remove the list of customer ids from the specified manual segment.

  ## Params

    * `id` - the unique identifier of the segment.

    * `ids` - a list of customer ids to add to the segment.

    * `opts` - HTTPoison options.

  ## Example

  ```elixir
  iex> Customerio.remove_from_segment(1, [1, 2, 3])
  {:ok, "..."}
  iex> Customerio.remove_from_segment(1000, [1, 2, 3])
  {:error, %Customerio.Error{}}
  ```
  """
  @spec remove_from_segment(
          id :: value,
          ids :: list(value),
          opts :: Keyword.t()
        ) :: {:ok, result} | {:error, Customerio.Error.t()}
  def remove_from_segment(id, ids, opts \\ []) do
    send_behavioral_request(
      :post,
      "segments/#{URI.encode(id |> to_string)}/remove_customers",
      %{ids: ids},
      opts
    )
  end

  @doc """
  Remove the list of customer ids from the specified manual segment.

  Raises `Customerio.Error` if fails.

  ## Params

    * `id` - the unique identifier of the segment.

    * `ids` - a list of customer ids to add to the segment.

    * `opts` - HTTPoison options.

  ## Example

  ```elixir
  iex> Customerio.remove_from_segment!(1, [1, 2, 3])
  "..."
  iex> Customerio.remove_from_segment(1000, [1, 2, 3])
  ** (Customerio.Error) "Epic fail!"
  ```
  """
  @spec remove_from_segment!(
          id :: value,
          ids :: list(value),
          opts :: Keyword.t()
        ) :: result | no_return()
  def remove_from_segment!(id, ids, opts \\ []) do
    remove_from_segment(id, ids, opts)
  else
    {:ok, result} -> result
    {:error, e} -> raise e
  end

  @doc """
  Trigger a campaign execution.

  ## Params

    * `id` - the unique identifier of the campaign.

    * `data` - data to be included in the campaign.

  ## Example

  ```elixir
  iex> Customerio.trigger_campaign(1, %{data: %{title: "hello"}})
  ```
  """

  def trigger_campaign(id, data \\ []) do
    send_api_request(:post, "/campaigns/#{URI.encode(id |> to_string)}/triggers", data)
  end
end
