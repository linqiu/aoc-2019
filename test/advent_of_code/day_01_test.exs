defmodule AdventOfCode.Day01Test do
  use ExUnit.Case

  import AdventOfCode.Day01

  test "part1" do
    input = "12\n14\n1969\n100756"
    result = part1(input)

    assert result == 34241
  end

  test "part2" do
    input = "14\n1969\n100756"
    result = part2(input)

    assert result == 2 + 966 + 50346
  end
end
