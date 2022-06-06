defmodule ElixirMangaDownloadr.Workflow do
  alias ElixirMangaDownloadr.FileTransfer
  alias ElixirMangaDownloadr.Mangas
  alias ElixirMangaDownloadr.PdfConverter

  @doc """
    Starts the workflow to process the manga using the manga slug
    manga_slug example: "neon-genesis-evangelion", "dragon-ball"
  """
  def process_manga(manga_slug) do
    Mangas.create_manga(manga_slug)
    |> Mangas.download_all_chapters()
    |> PdfConverter.convert_chapters()
    |> FileTransfer.copy_files()
  end
end
