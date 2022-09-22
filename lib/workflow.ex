defmodule ElixirMangaDownloadr.Workflow do
  alias ElixirMangaDownloadr.MangaWrapper.FileTransfer
  alias ElixirMangaDownloadr.MangaWrapper.Mangas
  alias ElixirMangaDownloadr.MangaWrapper.PdfConverter

  @doc """
    Starts the workflow to process the manga using the manga slug
    manga_slug example: "neon-genesis-evangelion", "dragon-ball", "hunter-x-hunter"
  """
  def process_manga(manga_slug) do
    #TODO: add possibility to send books to e-mail
    # Adicionar feedback de instruções para configurar o envio por e-mail

    Mangas.create_manga(manga_slug)
    |> Mangas.download_all_chapters()
    |> PdfConverter.convert_chapters()
    |> FileTransfer.copy_files()
  end
end
