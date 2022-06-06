defmodule ElixirMangaDownloadr.CLI do
  alias ElixirMangaDownloadr.Workflow

  def main(args) do
    args |> parse_args() |> do_process()
  end

  def parse_args(args) do
    options = OptionParser.parse(args)

    case options do
      {[manga: manga], _, _} -> [manga]
      {[help: true], _, _} -> :help
      _ -> :help
    end
  end

  def do_process([manga]) do
    Workflow.process_manga(manga)
  end

  def do_process(:help) do
    IO.puts """
    Usage:
    ./elixir_manga_downloadr --manga [manga-slug] (I.E: "clannad", "dragon-ball")

    Options:
    --help Show this help message.

    Description:
    Prints out an awesome message.
    """

    System.halt(0)
  end
end
