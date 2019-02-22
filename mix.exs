defmodule Customerio.Mixfile do
  use Mix.Project

  def project do
    [
      app: :customerio,
      version: "0.2.1",
      elixir: "~> 1.6",
      build_embedded: Mix.env() == :prod,
      start_permanent: Mix.env() == :prod,
      deps: deps(),
      description: description(),
      package: package(),
      docs: docs()
    ]
  end

  # Configuration for the OTP application
  #
  # Type "mix help compile.app" for more information
  def application do
    # Specify extra applications you'll use from Erlang/Elixir
    [
      extra_applications: [
        :logger
      ]
    ]
  end

  defp deps do
    [
      {:hackney, "~> 1.15"},
      {:ex_doc, "~> 0.0", only: :dev},
      {:jason, "~> 1.1"},
      {:exvcr, "~> 0.10", only: :test},
      {:inch_ex, "~> 2.0", only: [:docs, :dev, :test]}
    ]
  end

  defp description do
    """
    An Elixir client for the Customer.io event API.
    """
  end

  defp package do
    [
      name: :customerio,
      files: ["lib", "mix.exs", "README*"],
      maintainers: ["Dmitry Rubinshtein"],
      licenses: ["MIT"],
      links: %{"Gihub" => "https://github.com/virviil/customerio"}
    ]
  end

  defp docs do
    [
      main: "getting-started",
      extras: [
        "docs/Getting Started.md",
        "docs/Usage.md"
      ]
    ]
  end
end
