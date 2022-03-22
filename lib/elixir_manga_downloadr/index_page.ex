defmodule ElixirMangaDownloadr.IndexPage do
  def index_page(manga_name) do
    case Tesla.get("http://mangareader.cc/manga/#{manga_name}") do
      {:ok, %Tesla.Env{body: body, status: 200}} ->
        {:ok, document} = Floki.parse_document(body)
        document

      _ ->
        {:error, "Wasn't possible to reach the page"}
    end
  end
  
  ## TODO: add pattern matching to the fetch_manga_title function,
  # matching on {:ok, document} return of the Floki.parse_document
  # and adding the match for the error case
  def fetch_manga_title(html) do 
    [{_, [{_, _}], [title]}] = Floki.find(html, "h1")
    title
  end

  def fetch_chapters(html) do
    Floki.find(html, "ul>li>span>a")
    |> Floki.attribute("href")
  end
end
