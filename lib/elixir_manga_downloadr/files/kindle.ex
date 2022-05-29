defmodule ElixirMangaDownloadr.Kindle do
  alias ElixirMangaDownloadr.Files

  def save(manga_name) do
    case get_kindle_path() do
      :ok -> "It's alright now"
      {:error, :enoent} -> "It isn't okay"
    end
  end

  def greater_function_that_i_will_name_later(manga_name) do
    Files.enter_manga_path(manga_name)
    {:ok, list_of_files} = File.ls()

    Enum.each(list_of_files, fn pdf_chapter ->
      IO.inspect(pdf_chapter)
    end)

    IO.inspect(get_kindle_path())
  end

  defp get_kindle_path() do
    File.cd("/media/#{Files.get_username()}/Kindle/documents")
  end
end
