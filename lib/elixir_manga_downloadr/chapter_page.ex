defmodule ElixirMangaDownloadr.ChapterPage do
  @default_path "/tmp/"

  def get_chapter_pages(chapter_link) do
    case HTTPotion.get("https://mangayabu.top/ler/#{chapter_link}") do
      %HTTPotion.Response{body: body, headers: _headers, status_code: 200} ->
        fetch_pages(body)
        |> download_pages

      _ ->
        {:err, "not found"}
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
    Floki.find(html, "div.manga-navigations") |> Floki.attribute("img", "src")
  end

  def download_pages(pages_list) do
    Enum.map(pages_list, fn page -> download_page(page) end)
  end

  def download_page(page_url) do
    %HTTPotion.Response{body: body} = HTTPotion.get(page_url)
    {:ok, body}
  end

  def save_images(images_list) do
    images_list
    |> Enum.map(fn image -> save_image(image, @default_path) end)
  end

  #TODO
  # Dar o nome das imagens dinamicamente
  def save_image(image, path) do
    File.write(path, image)
  end
end
