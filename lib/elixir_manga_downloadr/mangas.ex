defmodule ElixirMangaDownloadr.Mangas do
  alias ElixirMangaDownloadr.Manga
  alias ElixirMangaDownloadr.IndexPage
  alias ElixirMangaDownloadr.ChapterPage

  def create_manga(manga_name) do
    manga =
      IndexPage.index_page(manga_name)
      |> IndexPage.get_manga_info()

    %Manga{
      manga_name: manga.manga_title,
      chapters_list: manga.chapters_list
    }
  end

  def download_all_chapters(%Manga{chapters_list: chapters_list}) do

    # TODO: cria a pasta principal (usando %Manga{manga_name: manga_name})

    Enum.map(chapters_list, fn chapter ->
      # TODO: cria a pasta para o capítulo e entra na pasta
      
      ChapterPage.get_chapter_pages(chapter)
      |> ChapterPage.fetch_pages()
      |> ChapterPage.download_and_save_pages()
    end)
  end

  defp create_folders() do
  end

  defp manage_files() do
  end
end
