# defmodule ExMangaDownloadr.Page do
#   def image(page_link) do
#     case HTTPotion.get("http://www.kissmanga.nl/#{page_link}") do
#       %HTTPotion.Response{body: body, headers: _headers, status_code: 200} ->
#         {:ok, fetch_image(body)}

#       _ ->
#         {:err, "not found"}
#     end
#   end
# end
