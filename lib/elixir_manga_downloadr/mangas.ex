defmodule ElixirMangaDownloadr.Mangas do

  alias ElixirMangaDownloadr.Manga
  alias ElixirMangaDownloadr.IndexPage
  alias ElixirMangaDownloadr.ChapterPage



  def create_manga(manga_name) do
    manga_name =
      IndexPage.index_page(manga_name)
      |> IndexPage.fetch_manga_title()

    chapters_list = 
      IndexPage.index_page(manga_name)
      |> IndexPage.fetch_chapters
    

    %Manga{manga_name: manga_name, chapters_list: chapters_list}
  end

  #def download_all_chapters() do
  #end

  #defp create_folders(manga_path) do
  #end

  #defp manage_files() do
  #end
end
