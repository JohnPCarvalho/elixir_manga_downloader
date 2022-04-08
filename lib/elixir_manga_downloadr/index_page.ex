defmodule ElixirMangaDownloadr.IndexPage do
  def get_manga_info(html) do
    manga_title = fetch_manga_title(html)
    chapters_list = fetch_chapters(html)

    %{manga_title: manga_title, chapters_list: chapters_list}
  end
  
  ## TODO: add pattern matching to the fetch_manga_title function,
  # matching on {:ok, document} return of the Floki.parse_document
  # and adding the match for the error case
  defp fetch_manga_title(html) do 
    [{_, [{_, _}], [title]}] = Floki.find(html, "h1")
    title
  end

  defp fetch_chapters(html) do
    Floki.find(html, "ul>li>span>a")
    |> Floki.attribute("href")
    |> clean_chapters_list()
    |> Enum.reverse()
  end

  defp clean_chapters_list(chapters_list) do
    Enum.filter(chapters_list, fn chapter -> chapter != "#" end)
  end
end
