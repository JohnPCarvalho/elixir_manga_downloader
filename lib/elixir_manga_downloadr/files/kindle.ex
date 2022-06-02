defmodule ElixirMangaDownloadr.Kindle do
  alias ElixirMangaDownloadr.Files

  def save(manga_name, kindle) when kindle == true do
    case enter_kindle_path() do
      :ok ->
        move_manga_to_kindle(manga_name)

      {:error, :enoent} ->
        "Kindle path was not found"
        # faz o restante do processo
    end
  end

  def move_manga_to_kindle(manga_path) do
    {:ok, kindle_path} = get_kindle_path()
    manga_name = Path.basename(manga_path)
    File.cp_r(manga_path, "#{kindle_path}/#{manga_name}/")
  end

  defp get_kindle_path() do
    File.cwd()
  end

  defp enter_kindle_path() do
    File.cd("/media/#{Files.get_username()}/Kindle/documents")
  end
end
