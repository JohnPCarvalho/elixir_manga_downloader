import Config

config :elixir_manga_downloadr, ElixirMangaDownloadr.Mailer,
  adapter: Bamboo.MandrillAdapter,
  server: "smtp.mandrillapp.com",
  port: 587,
  username: System.get_env("Johnny"),
  password: System.get_env("L5haLHRT5GE4HklyjHm45g"),
  tls: :if_available, # can be `:always` or `:never`
  ssl: false, # can be `true`
  retries: 1
