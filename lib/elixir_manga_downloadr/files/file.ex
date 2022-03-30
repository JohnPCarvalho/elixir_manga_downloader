defmodule ElixirMangaDownloadr.Files do
  def set_manga_path(manga_name) do
    File.cd("#{System.user_home()}/")
    create_folder(manga_name)
    get_manga_path
  end

  def get_manga_path() do
    {:ok, path} = File.cwd()
    path
  end

  def check_remaining_chapters(manga_path, chapters_list) do
    {:ok, files} = File.ls(manga_path)
    length(chapters_list) - length(files)
  end

  def create_folder(folder_name) do
    case File.mkdir(folder_name) do
      :ok -> File.cd(folder_name)
      :eexist -> File.cd(folder_name)
      {:error, _posix} -> "Something went wrong" 
    end
  end
end
