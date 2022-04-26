defmodule ElixirMangaDownloadr.Files do
  @home_dir System.user_home()

  def set_manga_path(manga_title) do
    case enter_manga_path(manga_title) do
      :ok ->
        get_manga_path(manga_title)

      :error ->
        create_folder(manga_title)
        enter_manga_path(manga_title)
        get_manga_path(manga_title)
    end
  end

  defp enter_manga_path(manga_title) do
    if File.exists?("#{@home_dir}/#{manga_title}") do
      File.cd("#{@home_dir}/#{manga_title}")
      :ok
    else
      IO.puts("This directory does not exist")
      :error
    end
  end

  defp get_manga_path(manga_title) do
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
    File.mkdir(folder_name)
  end
end
