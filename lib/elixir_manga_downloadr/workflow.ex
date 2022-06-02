defmodule ElixirMangaDownloadr.Workflow do
  alias ElixirMangaDownloadr.Files
  alias ElixirMangaDownloadr.Mangas
  alias ElixirMangaDownloadr.PdfConverter

  def process_manga(manga_name, kindle) do
    Mangas.create_manga(manga_name)
    |> Mangas.download_all_chapters()
    |> PdfConverter.convert_chapters()
    |> Kindle.save()
  end
end
