defmodule MangaReader do
  use Tesla

  plug Tesla.Middleware.BaseUrl, "mangareader.cc"
  plug Tesla.Middleware.JSON

  def manga_index_page(manga_name) do
    get("/manga")
  end
end
