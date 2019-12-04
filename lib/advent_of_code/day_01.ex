defmodule AdventOfCode.Day01 do
  def sum_additional_fuel(accum, n) when n <= 5 do
    accum
  end

  def sum_additional_fuel(accum, n) do
    fuel = div(n, 3) - 2
    sum_additional_fuel(accum + fuel, fuel)
  end

  def part1(input) do
    input
    |> String.split("\n", trim: true)
    |> Enum.map(fn x -> div(String.to_integer(x), 3) - 2 end)
    |> Enum.sum
  end

  def part2(input) do
    input
    |> String.split("\n", trim: true)
    |> Enum.map(fn x -> sum_additional_fuel(0, String.to_integer(x)) end)
    |> Enum.sum
  end
end
