defmodule ElixirMangaDownloadr.PdfConverter do
  alias ElixirMangaDownloadr.MangaChapter

  @page_size [600, 450]
  @image_size [600, 450]

  def convert_all, do: "nothing for now"

  def generate_chapter_pdf(%MangaChapter{chapter_title: chapter_title}, chapter_pages) do
    pdf = create_pdf(chapter_title)

    Enum.map(chapter_pages, fn chapter_page ->
      pdf
      |> add_page()
      |> add_image(chapter_page)
    end)

    Pdf.write_to(pdf, chapter_title)
  end

  def create_pdf(chapter_title) do
    Pdf.build([size: @page_size, compress: true], fn pdf ->
      pdf
      |> Pdf.set_info(title: chapter_title)
    end)
  end

  def add_page(pdf) do
    Pdf.add_page(pdf, @page_size)
  end

  def add_image(_pdf, image_path) do
    Pdf.add_image({0, 0}, image_path)
  end
end
