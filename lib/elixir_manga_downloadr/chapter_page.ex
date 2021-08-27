defmodule ElixirMangaDownloadr.ChapterPage do
  def pages(chapter_link) do
    IO.inspect(chapter_link)
    case HTTPotion.get("kissmanga.nl/#{chapter_link}") do
      %HTTPotion.Response {body: body, headers: _headers, status_code: 200} ->
        {:ok, fetch_pages(body)}
        _ ->
          {:err, "not found"}
          IO.inspect(chapter_link)
    end
  end

  defp fetch_pages(html) do
    Floki.find(html, "select#page_select")
    |> Enum.map(fn line ->
        case line do
          {"option", [{"value", value}, {"selected", "selected"}], _} -> value
          {"option", [{"value", value}], _} -> value
        end
    end)
  end
end
