defmodule ElixirMangaDownloadr.IndexPageTest do

  alias ElixirMangaDownloadr.IndexPage
  alias ElixirMangaDownloadr.MangaChapter

  @sample_manga_info %{manga_title: "Clannad", chapters_list: [@sample_manga_chapter, @sample_manga_chapter]}

  @sample_manga_chapter %MangaChapter{
    chapter_title: "Clannad Chapter 1",
    chapter_link: "www.clannad.com/chapter1"
  }

  setup do
    # salvar dado da variável html
  end

  describe "get_manga_info/1" do
    test "returns a tuple with manga_title and list of chapters" do

      scrapped_html = get_manga_info(html)
    end
  end


  describe "get_chapters/1" do
    test "get the chapters list and returns it in the MangaChapter struct" do

      chapters_list = get_chapters(html)
    end
  end
end
