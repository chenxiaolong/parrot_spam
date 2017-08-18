defmodule ParrotSpam do
  def main do
    System.argv
    |> Enum.filter(&(String.length(&1) > 0))
    |> spam
  end

  def spam([]) do
    IO.puts :stderr, "Nothing to repeat"
    System.halt 1
  end

  def spam(parrots) do
    parrots = Stream.cycle(parrots)

    Stream.zip(
      parrots,
      parrots |> Stream.map(&String.length/1) |> Stream.scan(&+/2)
    )
    |> Stream.take_while(fn {_, used} -> used <= 4000 end)
    |> Enum.each(fn {p, _} -> IO.write p end)

    IO.puts ""
  end
end

ParrotSpam.main
