# Usage

## Setup

Specify configuration in your config files:

```elixir
# config/config.exs

config :customerio,
  site_id: %your_site_id%,
  api_key: %your_api_key%
```

Now, you can call all the functions from every place in your code.

## Identify logged in customers

Identify logged in customers

Tracking data of logged in customers is a key part of **Customer.io**. In order to send triggered emails, we must know the email address of the customer. You can also specify any number of customer attributes which help tailor **Customer.io** to your business.

Attributes you specify are useful in several ways:

As customer variables in your triggered emails. For instance, if you specify the customer's name, you can personalize the triggered email by using it in the subject or body.

As a way to filter who should receive a triggered email. For instance, if you pass along the current subscription plan (free / basic / premium) for your customers, you can set up triggers which are only sent to customers who have subscribed to a particular plan (e.g. "premium").

You'll want to indentify your customers when they sign up for your app and any time their key information changes. This keeps **Customer.io** up to date with your customer information.

```elixir
Customerio.identify(
  5,                                        # id
  %{                                        # attributes map
    email: "bob@example.com",
    created_at: :os.system_time(:seconds),
    first_name: "Bob",
    plan: "basic"
  }
)
```

## Deleting customers

Deleting a customer will remove them, and all their information from Customer.io. Note: if you're still sending data to **Customer.io** via other means (such as the javascript snippet), the customer could be recreated.

```elixir
Customerio.identify(
  5                                          # id
)
```

## Tracking a custom event

Now that you're identifying your customers with **Customer.io**, you can now send events like "purchased" or "watchedIntroVideo". These allow you to more specifically target your users with automated emails, and track conversions when you're sending automated emails to encourage your customers to perform an action.

``` elixir
Customerio.track(
  5,                                         # id
  "purchase",                                # name
  %{                                         # attributes map
    type: "socks",
    price: "13.99"
  }
)
```

**Note**: If you'd like to track events which occurred in the past, you can include a timestamp attribute (in seconds since the epoch), and we'll use that as the date the event occurred.

```elixir
Customerio.track(5, "purchase", %{type: "socks", price: "13.99", timestamp: 1365436200)
```

## Tracking anonymous events

You can also send anonymous events, for situations where you don't yet have a customer record but still want to trigger a campaign:

```elixir
Customerio.anonymous_track("help_enquiry", %{recipient: 'user@example.com')
```

Use the recipient attribute to specify the email address to send the messages to. See [documentation on how to use anonymous events for more details](https://learn.customer.io/recipes/invite-emails.html).

## Page View Events

You can send a page view event to **Customer.io** directly, defining a customer and page url.

```elixir
Customerio.track_page_view(5, "http://google.com", %{refferer: "bob"})
```

> The Javascript snippet automatically sends these events based on when any page that includes it is loaded.
