defmodule ElixirMangaDownloadr.IndexPage do
  #@spec chapters(any) :: {:err, <<_::72>>} | {:ok, any, list}
  #def chapters(manga_name) do
  #end

  def fetch_manga_title(html) do
    {:ok, document} = Floki.parse_document(html)
      
    [{_, [{_, _}], [title]}] = Floki.find(document, "h1") 
    title
  end

  def fetch_chapters(html) do
    Floki.find(html, "ul>li>span>a")
    |> Floki.attribute("href")
  end
end
