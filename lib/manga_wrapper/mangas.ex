defmodule ElixirMangaDownloadr.Mangas do
  alias ElixirMangaDownloadr.Manga

  import ElixirMangaDownloadr.IndexPage
  import ElixirMangaDownloadr.ChapterPage
  import ElixirMangaDownloadr.Files

  import MainPage
  import Chapters

  def create_manga(manga_name) do
    manga =
      main_manga_page(manga_name)
      |> get_manga_info()

    %Manga{
      manga_name: manga.manga_title,
      chapters_list: manga.chapters_list
    }
  end

  def download_all_chapters(%Manga{manga_name: manga_name, chapters_list: chapters_list}) do
    manga_path = set_manga_path(manga_name)

    if new_download?(manga_path) == true do
      chapters_list
      |> Enum.map(fn chapter ->
        File.cd(manga_path)
        create_folder(chapter.chapter_title)
        File.cd(chapter.chapter_title)
        fetch_and_download(chapter.chapter_link)
        manga_path
      end)
    else
      File.cd(manga_path)
      chapters_downloaded = check_downloaded_chapters(manga_path)

      Enum.drop(chapters_list, chapters_downloaded - 1)
      |> Enum.map(fn chapter ->
        File.cd(manga_path)
        create_folder(chapter.chapter_title)
        File.cd(chapter.chapter_title)
        fetch_and_download(chapter.chapter_link)
      end)

      manga_path
    end
  end

  defp new_download?(manga_path) do
    {:ok, files} = File.ls(manga_path)
    length(files) == 0
  end

  defp fetch_and_download(chapter) do
    chapter_page(chapter)
    |> fetch_pages()
    |> download_and_save_pages
  end
end
