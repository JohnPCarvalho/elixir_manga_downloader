defmodule ElixirMangaDownloadr.MangaWrapper.FileTransfer do
  alias ElixirMangaDownloadr.MangaWrapper.Files

  @kindle_path "/media/#{Files.get_username()}/Kindle/documents"

  def copy_files(manga_path) do
    if File.exists?(@kindle_path) do
      move_manga_to_kindle(manga_path)
    else
      move_manga_to_documents(manga_path)
    end
  end

  defp move_manga_to_documents(manga_path) do
    File.cp_r(manga_path, "/home/johnny/Documents/Clannad")
  end

  defp move_manga_to_kindle(manga_path) do
    manga_name = Path.basename(manga_path)
    File.cp_r(manga_path, "#{@kindle_path}/#{manga_name}/")
  end
end
