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

    Enum.map(pages_list, fn page ->
      IO.puts("Page: #{page}")

      download_page(page)
      |> save_image("#{page}.jpg")

      IO.puts("saving images...")
    end)
  end

  def download_page(page_url) do
    {:ok, %Tesla.Env{body: image}} = Tesla.get(page_url)
    image
  end

 # def save_images(images_list) do
 #   images_list
 #   |> Enum.map(fn image -> save_image(image, @default_path) end)
 # end

  def save_image(image, path) do
    File.write(path, image)
  end
end
