defmodule Chapters do
  use Tesla

  plug(Tesla.Middleware.FollowRedirects, max_redirects: 3)

  def chapter_page(chapter_link) do
    case get(chapter_link) do
      {:ok, %Tesla.Env{body: body, status: 200}} ->
         body 
    end
  end

  defp find_redirect_link() do
  end
end
