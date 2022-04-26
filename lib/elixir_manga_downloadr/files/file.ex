defmodule ElixirMangaDownloadr.Files do
  @home_dir System.user_home()

  def set_manga_path(manga_name) do
    File.cd("#{@home_dir}/")
    # TODO: adicionar condicional para checar se a pasta já existe
    if File.exists?("#{manga_name}") do
      File.cd(manga_name)
    else
      File.mkdir(manga_name)
      File.cd(manga_name)
    end

    get_manga_path()
  end

  defp enter_manga_path(manga_title) do
    File.cd("#{@home_dir}/#{manga_title}")
  end

  def get_manga_path() do
    {:ok, path} = File.cwd()
    path
  end

  def get_manga_path(manga_title) do
    enter_manga_path(manga_title)
    {:ok, path} = File.cwd()
    path
  end

  def get_all_chapter_paths(manga_title) do
    enter_manga_path(manga_title)
    {:ok, chapters_list} = File.ls()
    chapters_list
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
    # TODO: separar essa função em duas. create_folder() deve apenas criar a pasta e não entrar nela também
    File.mkdir(folder_name)
    File.cd(folder_name)
  end
end
