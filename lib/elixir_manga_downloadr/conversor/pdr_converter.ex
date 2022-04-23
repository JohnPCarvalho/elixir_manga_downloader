defmodule PdfConverter do
  @page_size [600, 450]
  @image_size [600, 450]

  def create_test_pdf() do
    Pdf.build([size: [600, 450], compress: true], fn pdf ->
      pdf
      |> Pdf.set_info(title: "Demo PDF")
      |> Pdf.add_page([600, 450])
      |> Pdf.add_image(
        {0, 0},
        "/home/johnny/Neon Genesis Evangelion/Neon Genesis Evangelion Chapter 1/1.jpg", [100, 150]
      )
      |> Pdf.write_to("test.pdf")
    end)
  end
end
