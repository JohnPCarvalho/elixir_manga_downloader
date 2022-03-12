defmodule ElixirMangaDownloadr.ChapterPage do
  #@default_path "/tmp/"

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
    [{ _, [{_, _}, {_, _}] ,[chapters_list]}] = chapters 

    String.split(chapters_list, ",")
  end

  # def download_pages(pages_list) do
  #  Enum.map(pages_list, fn page -> download_page(page) end)
  # end

  # def download_page(page_url) do
  #  %HTTPotion.Response{body: body} = HTTPotion.get(page_url)
  #  {:ok, body}
  # end

  # def save_images(images_list) do
  #  images_list
  #  |> Enum.map(fn image -> save_image(image, @default_path) end)
  # end

  #
  # def save_image(image, path) do
  #  File.write(path, image)
  # end
end
