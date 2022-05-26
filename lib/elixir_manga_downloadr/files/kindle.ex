defmodule ElixirMangaDownloadr.Kindle do
  alias ElixirMangaDownloadr.Files

  def save(manga_name) do
    case get_kindle_path() do
      {:error, :enoent} -> "It isn't okay"
      :ok -> "It's alright now"
    end
  end

  def greater_function_that_i_will_name_later() do
    Files.enter_manga_path(manga_name)
    {:ok, list_of_files} = File.ls()

    Enum.each(list_of_files, fn pdf_chapter ->
      IO.inspect(pdf_chapter)
    end)

    IO.inspect(get_kindle_path())
  end

  defp get_kindle_path() do
    # Kindle path in Linux distros
    File.cd("/media/#{Files.get_username()}/Kindle")
    # TODO: get other OS's Kindle path
  end
end
