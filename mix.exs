defmodule ElixirMangaDownloadr.MixProject do
  use Mix.Project

  def project do
    [
      app: :elixir_manga_downloadr,
      version: "0.1.0",
      elixir: "~> 1.12",
      start_permanent: Mix.env() == :prod,
      deps: deps()
    ]
  end

  # Run "mix help compile.app" to learn about applications.
  def application do
    [
      extra_applications: [:logger]
    ]
  end

  # Run "mix help deps" to learn about dependencies.
  defp deps do
    [
      {:ibrowse, github: "cmullaparthi/ibrowse", tag: "v4.4.0", override: true},
      {:tesla, "~> 1.4"},
      {:floki, "~> 0.31.0"},
      {:porcelain, "~> 2.0.3"}
    ]
  end
end
