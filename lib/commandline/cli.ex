defmodule Commandline.CLI do
  def main(args) do
    options = [switches: [file: :string], aliases: [f: :file]]

    {opts, _, _} = OptionParser.parse(args, options)
    IO.inspect opts, label: "Command Line Arguments"
  end
end
