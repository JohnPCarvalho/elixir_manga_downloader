defmodule ElixirMangaDownloadr.IndexPage do
  def index_page(manga_name) do
    case Tesla.get("http://mangareader.cc/manga/#{manga_name}") do
      {:ok, %Tesla.Env{body: body, status: 200}} -> 
        body
        |> fetch_manga_title()
        |> fetch_chapters()
      _ -> {:error, "Wasn't possible to reach the page"}
    end
  end

  def fetch_manga_title(html) do
    {:ok, document} = Floki.parse_document(html)

    [{_, [{_, _}], [title]}] = Floki.find(document, "h1")
    title
  end

  def fetch_chapters(html) do
    Floki.find(html, "ul>li>span>a")
    |> Floki.attribute("href")
  end
end
