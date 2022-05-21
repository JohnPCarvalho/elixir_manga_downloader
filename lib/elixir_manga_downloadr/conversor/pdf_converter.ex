defmodule ElixirMangaDownloadr.PdfConverter do
  alias ElixirMangaDownloadr.Files
  require Logger

  # Kindle maximum resolution
  @image_dimensions "600x800"
  # comfortable PDF file number of pages
  @pages_per_volume 250
  # the best value is probably the total number of CPU cores
  @maximum_pdf_generation 2
  # has to wait for huge number of async Tasks at once
  @await_timeout_ms 1_000_000

  def convert_chapters(manga_path) do
    Files.organize_chapters()
    |> Enum.map(fn chapter ->
      File.cd(chapter)

      optimize_images(chapter)
      |> compile_pdfs(manga_path)

      File.cd("../")
    end)

    manga_path
  end

  def optimize_images(chapter_folder) do
    Logger.debug(
      "Running mogrify to convert all images from #{chapter_folder} down to Kindle supported size (600x800)"
    )

    Porcelain.shell("mogrify -resize #{@image_dimensions} *.jpg")
    chapter_folder
  end

  def compile_pdfs(directory, manga_name) do
    {:ok, final_files_list} = File.ls()

    final_files_list
    |> Files.reorganize_images("jpg")
    |> Enum.map(&"#{directory}/#{&1}")
    |> chunk(@pages_per_volume)
    |> Enum.with_index()
    |> chunk(@maximum_pdf_generation)
    |> Enum.map(fn batch ->
      batch
      |> Enum.map(&compile_volume(manga_name, directory, &1))
      |> Enum.map(&Task.await(&1, @await_timeout_ms))
    end)

    directory
  end

  def compile_volume(manga_name, directory, {chunk, index}) do
    {:ok, convert_cmd} = prepare_volume(manga_name, directory, chunk, index)
    Logger.debug("Compiling volume #{directory}.")
    Task.async(fn -> Porcelain.shell(convert_cmd) end)
  end

  def prepare_volume(manga_name, directory, chunk, index) do
    pdf_chapter_name = String.replace(directory, " ", "_")
    {:ok, "convert $(ls -1 *.jpg | sort -V) #{pdf_chapter_name}.pdf"}
  end

  def chunk(collection, default_size) do
    size = [Enum.count(collection), default_size] |> Enum.min()
    Enum.chunk_every(collection, size, size, [])
  end
end
