defmodule ElixirMangaDownloadr.Mangas do

  
  alias ElixirMangaDownloadr.IndexPage
  



  def get_manga(manga_name) do
    IndexPage.fetch_manga_title(manga_name)
  end

  #def download_all_chapters() do
  #end

  #defp create_folder() do
  #end

  #defp manage_files() do
  #end
end
