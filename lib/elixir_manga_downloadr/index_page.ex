defmodule ElixirMangaDownloadr.IndexPage do
  @spec chapters(any) :: {:err, <<_::72>>} | {:ok, any, list}
  def chapters(manga_name) do
    case HTTPotion.get("mangareader.cc/manga/#{manga_name}") do
      %HTTPotion.Response{body: body, headers: _headers, status_code: 200} ->
        {:ok, fetch_manga_title(body), fetch_chapters(body)}

      _ ->
        {:err, "not found"}
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
