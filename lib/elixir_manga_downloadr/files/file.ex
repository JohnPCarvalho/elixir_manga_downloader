defmodule ElixirMangaDownloadr.Files do
  @home_dir System.user_home()

  def set_manga_path(manga_title) do
    create_folder("#{@home_dir}/#{manga_title}")
    enter_manga_path(manga_title)
    get_manga_path(manga_title)
  end

  def enter_manga_path(manga_title) do
    File.cd("#{@home_dir}/#{manga_title}")
  end

  defp get_manga_path(manga_title) do
    enter_manga_path(manga_title)
    {:ok, path} = File.cwd()
    path
  end

  def get_all_chapter_paths(chapter_title) do
    enter_manga_path(chapter_title)
    {:ok, chapters_list} = File.ls()
    chapters_list
  end

  def get_chapter_pages() do
    {:ok, pages} = File.ls()
    pages
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
