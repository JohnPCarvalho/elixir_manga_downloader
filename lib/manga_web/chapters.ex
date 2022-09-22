defmodule Chapters do

  import Logger
  use Tesla

 plug Tesla.Middleware.FollowRedirects, max_redirects: 3

  def chapter_page(chapter_link) do
    case get(chapter_link) do
      {:ok, %Tesla.Env{body: body, status: 200}} ->
        {:ok, parsed_body} = Floki.parse_document(body)
        parsed_body

      {:ok, %Tesla.Env{body: _body, status: 404}} ->
        Logger.error("Page not found")
    end
  end
end
