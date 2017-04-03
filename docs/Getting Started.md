# Getting Started

## Installation

The package can be installed
by adding `customerio` to your list of dependencies in `mix.exs`:

```elixir
def deps do
  [{:customerio, "~> 0.1.0"}]
end
```

After that execute:

```bash
$ mix deps.get
```

## API client vs. JavaScript snippet


The **JavaScript** snippet tracks basic behavior for you just by copy/pasting it onto your site. In many cases, using the **JavaScript** snippet will be easier to integrate with your app, but there are several reasons why sending events from your backend is useful:

You’re not planning on triggering emails based on how customers interact with your website (e.g. users who haven’t visited the site in X days)
You’re using the javascript snippet, but have a few events you’d like to send from your backend system. They will work well together!
You’d rather not have another javascript snippet slowing down your frontend. Our snippet is asynchronous (doesn’t affect initial page load) and very small, but we understand.
In the end, the decision on whether or not to send events from your backend or the **JavaScript** snippet should be based on what works best for you. You’ll be able to integrate fully with **Customer.io** with either approach.
