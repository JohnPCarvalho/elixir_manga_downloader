defmodule ElixirMangaDownloadr.ChapterPage do
  def get_chapter_pages(chapter_link) do
    case Tesla.get("http://mangareader.cc/chapter/#{chapter_link}") do
      {:ok, %Tesla.Env{body: body, status: 200}} ->
        body

      _ ->
        {:error, "It was not possible to reach the page"}
    end
  end

  # It loads all pages at once
  @spec fetch_pages(
          binary
          | [
              binary
              | {:comment, binary}
              | {:pi | binary, binary | [{any, any}], list}
              | {:doctype, binary, binary, binary}
            ]
        ) :: list
  def fetch_pages(html) do
    chapters = Floki.find(html, "p#arraydata")
    [{_, [{_, _}, {_, _}], [chapters_list]}] = chapters

    String.split(chapters_list, ",")
  end

  def download_and_save_pages(pages_list) do
    IO.puts("Downloading pages from #{pages_list}")

    pages_list
    |> Enum.with_index()
    |> Enum.map(fn {page, index} ->
      download_page(page)
      |> save_image("#{index}.jpg")
    end)
  end

  defp download_page(page_url) do
    {:ok, %Tesla.Env{body: image}} = Tesla.get(page_url)
    image
  end

  defp save_image(image, path) do
    File.write(path, image)
  end
end
