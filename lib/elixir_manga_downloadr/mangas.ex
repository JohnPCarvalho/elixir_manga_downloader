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

    if needs_resuming_download?(manga_path, chapters_list) == false do
      chapters_list
      |> Enum.with_index()
      |> Enum.map(fn {chapter, index} ->
        File.cd(manga_path)
        create_folder("#{index + 1}")

        chapter_page(chapter)
        |> fetch_pages()
        |> download_and_save_pages
      end)
    else
      # resumes download functions called here...
    end
  end

  defp needs_resuming_download?(manga_path, chapters_list) do 
      false
    else
      true
    end
  end
end
