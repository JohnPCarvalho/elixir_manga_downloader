defmodule ElixirMangaDownloadr.MangaWrapper.Kindle.Email  do
  import Bamboo.Email

  def epub_email(to, file) do
    new_email(
      to: to,
      from: "myemailserver@gmail.com",
      subject: "Your book has arrived!",
      html_body: "<strong>Check out your new books on your kindle!</strong>"
      text_body: "It may take a while."
    )
    |> put_attachment(file)
  end
end
