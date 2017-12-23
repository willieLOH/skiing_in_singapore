defmodule SkiingInSingapore do
  def solve!(filename \\ "test.txt") do
    list = load_data(filename)
    map = Map.new(list)

    {max_length, longest_routes} =
      list
      |> Enum.map(fn {coor, _value} -> Route.find_next(coor, map) end)
      |> Ruler.find_longest()

    {max_steep, _longest_route} = Ruler.find_steepest(longest_routes, map)

    %{longest: max_length, steepest: max_steep}
  end

  defp load_data(filename) do
    [_info | input_list] =
      filename |> File.read!() |> String.trim() |> String.split("\n")

    input_list
    |> Enum.with_index()
    |> Enum.flat_map(fn({row, index}) -> insert_line(index, row) end)
  end

  defp insert_line(row_index, line) do
    line
    |> String.split("\s")
    |> Enum.with_index()
    |> Enum.map(fn {value, col_index} ->
         { {row_index, col_index}, String.to_integer(value) }
       end)
  end
end
