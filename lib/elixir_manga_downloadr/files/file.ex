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

  def get_manga_path(manga_title) do
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
    File.mkdir_p(folder_name)
  end

  def reorganize_images(list_of_images, extension) do
    list_of_images
    |> Enum.map(fn image ->
      Path.basename(image, ".jpg")
    end)
    |> Enum.map(fn file ->
      String.to_integer(file, 10)
    end)
    |> Enum.sort()
    |> Enum.map(fn item -> "0#{item}.#{extension}" end)
  end

  def organize_chapters() do
    {:ok, files} = File.ls()

    chapter_prefix =
      files
      |> List.first()
      |> String.split(" ")
      |> Enum.drop(-1)
      |> Enum.join(" ")

    list_of_chapters =
      files
      |> Enum.map(fn chapter -> String.split(chapter, " ") end)
      |> Enum.map(fn item -> List.last(item) end)
      |> Enum.map(fn item -> String.to_integer(item, 10) end)
      |> Enum.sort()
      |> Enum.map(fn item -> "#{chapter_prefix} #{item}" end)

    list_of_chapters
  end

  def move_file(file_path, file_destination) do
    File.cp(file_path, file_destination)
  end

  def clear_directory(directory) do
    enter_manga_path(directory)
    files = organize_chapters()

    Enum.map(files, fn file ->
      File.cd(file)

      pdf_chapter =
        get_chapter_pages()
        |> Enum.find(fn file -> String.contains?(file, "pdf") end)

      move_file(pdf_chapter, "../#{pdf_chapter}")
      File.cd("../")
    end)

    remove_all_folders()
  end

  defp remove_all_folders() do
    {:ok, files} = File.ls()

    directories_list = Enum.filter(files, fn file -> Path.extname(file) != ".pdf" end)

    Enum.each(directories_list, fn directory ->
      File.rm_rf(directory)
    end)
  end

  def get_username() do
    [username | _rest] =
      System.user_home()
      |> String.split("/")
      |> Enum.reverse()

    username
  end
end
