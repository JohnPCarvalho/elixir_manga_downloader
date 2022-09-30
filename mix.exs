defmodule ElixirMangaDownloadr.MixProject do
  use Mix.Project

  def project do
    [
      app: :elixir_manga_downloadr,
      version: "0.1.0",
      elixir: "~> 1.12",
      start_permanent: Mix.env() == :prod,

      escript: [main_module: ElixirMangaDownloadr.CLI],

      deps: deps()
    ]
  end

  # Run "mix help compile.app" to learn about applications.
  def application do
    [
      extra_applications: [:logger, :bamboo, :bamboo_smtp]
    ]
  end

  # Run "mix help deps" to learn about dependencies.
  defp deps do
    [
      {:ibrowse, github: "cmullaparthi/ibrowse", tag: "v4.4.0", override: true},
      {:tesla, "~> 1.4"},
      {hackney, ".*", {git, "git://github.com/benoitc/hackney.git", {branch, "master"}}},
      {:floki, "~> 0.31.0"},
      {:porcelain, "~> 2.0.3"},
      {:bamboo, "~> 2.2.0"},
      {:bamboo_smtp, "~> 4.1.0"}
    ]
  end
end
