defmodule MangaReader do
  use Tesla

  plug Tesla.Middleware.BaseUrl, "http://mangareader.cc/manga/"
  plug Tesla.Middleware.Headers, [{"authorization", "token xyz"}]
  plug Tesla.Middleware.JSON

  def manga_page(manga_name) do
    get(manga_name)
  end
end
