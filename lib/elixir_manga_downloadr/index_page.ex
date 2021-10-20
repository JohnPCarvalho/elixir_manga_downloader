defmodule ElixirMangaDownloadr.IndexPage do
  @spec chapters(any) :: {:err, <<_::72>>} | {:ok, any, list}
  def chapters(manga_name) do
    case HTTPotion.get("https://mangayabu.top/manga/#{manga_name}/") do
      %HTTPotion.Response{body: body, headers: _headers, status_code: 200} ->
        {:ok, fetch_manga_title(body), fetch_chapters(body)}

      _ ->
        {:err, "not found"}
    end
  end

  def fetch_manga_title(html) do
    Floki.find(html, "h1")
    |> Enum.map(fn {"h1", [], [title]} -> title end)
    |> Enum.at(0)
  end

  def fetch_chapters(html) do
    Floki.find(html, "div.single-chapter a")
    |> Enum.map(fn {"a", [{_, _}, {_, _}, {"href", url}], _} -> url end)
  end
end
