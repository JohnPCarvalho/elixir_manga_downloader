defmodule MainPage do
  import Logger
  use Tesla

  plug(Tesla.Middleware.BaseUrl, "http://mangareader.cc/")
  plug(Tesla.Middleware.FollowRedirects, max_redirects: 3)

  def main_manga_page(manga_name) do
    case get("manga/#{manga_name}") do
      {:ok, %Tesla.Env{body: body, status: 200}} ->
        {:ok, parsed_body} = Floki.parse_document(body)
        parsed_body

      {:ok, %Tesla.Env{body: _body, status: 404}} ->
        Logger.error("Page not found")
    end
  end
end
