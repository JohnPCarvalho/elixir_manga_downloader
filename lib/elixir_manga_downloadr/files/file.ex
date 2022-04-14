defmodule ElixirMangaDownloadr.Files do
  def set_manga_path(manga_name) do
    File.cd("#{System.user_home()}/")    
    # TODO: adicionar condicional para checar se a pasta já existe
    if File.exists?("#{manga_name}") do
      File.cd(manga_name)
    else
      File.mkdir(manga_name)
      File.cd(manga_name)
    end
    get_manga_path()
  end

  def get_manga_path() do
    {:ok, path} = File.cwd()
    path
  end

  def remaining_chapters(manga_path, chapters_list) do
    {:ok, files} = File.ls(manga_path)
    length(chapters_list) - length(files)
  end

  def check_downloaded_chapters(manga_path) do
    {:ok, files} = File.ls(manga_path)
    length(files)
  end


  def create_folder(folder_name) do
    File.mkdir(folder_name)
    File.cd(folder_name)
    end
end
