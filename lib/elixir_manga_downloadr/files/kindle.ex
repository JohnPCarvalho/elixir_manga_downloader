defmodule ElixirMangaDownloadr.Kindle do
  alias ElixirMangaDownloadr.Files

  def save(manga_name) do
    case get_kindle_path() do
      :ok -> "It's alright now"
      {:error, :enoent} -> "It isn't okay"
    end
  end

  def move_manga_to_kindle(manga_name) do
    manga_path = Files.get_manga_path(manga_name)
    kindle_path = get_kindle_path()

    File.cp(manga_path, "#{kindle_path}/#{manga_name}")
  end

  defp get_kindle_path() do
    File.cd("/media/#{Files.get_username()}/Kindle/documents")
  end
end
