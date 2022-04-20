defmodule ElixirMangaDownloadr.IndexPage do
  alias ElixirMangaDownloadr.MangaChapter

  def get_manga_info(html) do
    manga_title = get_manga_title(html)
    chapters_list = get_chapters(html)

    %{manga_title: manga_title, chapters_list: chapters_list}
  end

  ## TODO: add pattern matching to the fetch_manga_title function,
  # matching on {:ok, document} return of the Floki.parse_document
  # and adding the match for the error case
  def get_manga_title(html) do
    [{_, [{_, _}], [title]}] = Floki.find(html, "h1")
    title
  end

  defp order_chapters(chapters_list) do
    Enum.reverse(chapters_list)
  end

  def get_chapters(html) do
    Floki.find(html, "span.leftoff>a")
    |> order_chapters()
    |> Enum.map(fn list_item ->
      chapter_title = Floki.text(list_item)

      chapter_link =
        Floki.find(list_item, "a")
        |> Floki.attribute("href")

      %MangaChapter{chapter_title: chapter_title, chapter_link: chapter_link}
    end)
  end
end
