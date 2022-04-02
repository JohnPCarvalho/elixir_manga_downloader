defmodule MainPage do
  use Tesla

  plug Tesla.Middleware.BaseUrl, "http://mangareader.cc/" 

  def main_manga_page(manga_name) do
    get("manga/#{manga_name}")
  end
end
