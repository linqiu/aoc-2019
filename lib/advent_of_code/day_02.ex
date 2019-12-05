defmodule AdventOfCode.Day02 do
  # iex(14)> int_list = [2, 0, 0, 0, 99]
  # [2, 0, 0, 0, 99]
  # iex(15)> int_list |> Enum.chunk_every(4)
  # [[2, 0, 0, 0], 'c']
  # iex(16)> list
  # ["2", "0", "0", "0", "99"]
  # iex(17)> list |> Enum.chunk_every(4)
  # [["2", "0", "0", "0"], ["99"]]
  # until i figure out what 99 turned into 'c' i'll be doing this the hard way

  def process_code(m1, m2, v, list, function) do
    {:ok, value1 } = Enum.fetch(list, String.to_integer(m1))
    {:ok, value2 } = Enum.fetch(list, String.to_integer(m2))
    total = function.(String.to_integer(value1), String.to_integer(value2))
    List.replace_at(list, String.to_integer(v), Integer.to_string(total))
  end

  def gravity_assist(list, instruction, counter) do
    [head | _] = instruction
    if head == "99" do
      list
    else
      [code, m1, m2, v] = instruction

      new_list = case code do
        "1" -> process_code(m1, m2, v, list, fn(a, b) -> a + b end)
        "2" -> process_code(m1, m2, v, list, fn(a, b) -> a * b end)
      end

      {:ok, new_instruction } = new_list
        |> Enum.chunk_every(4)
        |> Enum.fetch(counter + 1)
      
      gravity_assist(new_list, new_instruction, counter + 1)
    end
  end

  def part1(input) do
    list = input
    |> String.split(",", trim: true)

    {:ok, instruction } = list
      |> Enum.chunk_every(4)
      |> Enum.fetch(0)

    gravity_assist(list, instruction, 0)
  end

  def get_new_inputs(input1, input2) do
    if input2 < 99 do
      [input1, input2 + 1]
    else
      [input1 + 1, 0]
    end
  end
    
  def find_number(list, opcode, input1, input2) when opcode == "19690720" do
    { input1, input2 }
  end

  def find_number(list, opcode, input1, input2) do
    [head, _, _ | tail] = list
    new_list = [head, Integer.to_string(input1), Integer.to_string(input2) | tail]

    {:ok, instruction } = new_list
      |> Enum.chunk_every(4)
      |> Enum.fetch(0)

    answer_list = gravity_assist(new_list, instruction, 0)
    [head | _] = answer_list

    [new_input1, new_input2] = get_new_inputs(input1, input2)
    find_number(list, head, new_input1, new_input2)
  end

  def part2(input) do
    list = input
    |> String.split(",", trim: true)

    find_number(list, "0", 0, 0)
  end
end
