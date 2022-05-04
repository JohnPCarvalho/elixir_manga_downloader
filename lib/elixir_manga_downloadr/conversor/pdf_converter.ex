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

  def testing_this_thing(directory, manga_name) do
    {:ok, files} = File.ls(directory)
    File.cd(directory)

    Enum.map(files, fn chapter ->
      File.cd(chapter)

      optimize_images(chapter)
      |> compile_pdfs(manga_name)

      File.cd("../")
    end)
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
    require IEx
    IEx.pry()
    Logger.debug("Compiling volume #{index + 1}.")
    Task.async(fn -> Porcelain.shell(convert_cmd) end)
  end

  def prepare_volume(manga_name, directory, chunk, index) do
    volume_directory = "#{directory}/#{manga_name}_#{index + 1}"
    volume_file = "#{volume_directory}.pdf"
    Files.create_folder(volume_directory)

    Enum.each(chunk, fn file ->
      [destination_file | _rest] = String.split(file, "/") |> Enum.reverse()
      File.rename(file, "#{volume_directory}/#{destination_file}")
    end)

    {:ok, "convert #{volume_directory}/*.jpg #{volume_file}"}
  end

  def chunk(collection, default_size) do
    size = [Enum.count(collection), default_size] |> Enum.min()
    Enum.chunk(collection, size, size, [])
  end
end
