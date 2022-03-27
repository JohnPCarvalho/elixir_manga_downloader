defmodule ElixirMangaDownloadr.File do

  # TODO: verificar o Sistema Operacional do usuário para escolher uma pasta "padrão"
  # para salvar os arquivos.
  
  @unix_path "~/Documents/"
  @mac_path "nao_sei_porra_nenhuma/"
  @windows_path "c:/Users/Public/"

  def create_folder(path) do
    File.mkdir(path)
  end

  
end
