defmodule ElixirMangaDownloadr.Kindle do
  def save() do
  end

  defp get_kindle_path() do
    [username, _rest] = System.user_home() |> String.split("/") |> Enum.reverse()
    # Kindle path in Linux distros
    File.cd("/media/#{username}/Kindle")
  end
end
