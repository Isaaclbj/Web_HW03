defmodule Practice.Factor do
  def factor(num) do
    helper(num, 2, [])
  end

  def helper(num, div, list) do
    cond do
      div > num ->
        list
      div == num ->
        list ++ [num]
      rem(num, div) == 0 ->
          helper(div(num, div), div, list ++ [div])
      rem(num, div) != 0 ->
          helper(num, div + 1, list)
    end
  end
end
