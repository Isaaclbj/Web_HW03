defmodule Practice.Calc do
  def parse_float(text) do
    {num, _} = Float.parse(text)
    num
  end

  def calc(expr) do
    # This should handle +,-,*,/ with order of operations,
    # but doesn't need to handle parens.
    expr
    |> String.split(~r/\s+/)
    |> intoTokens
    |> findMultiDiv
    |> findPlusMi
    |> hd
    |> tupleToNum
  end

  def intoTokens(los) do
    IO.inspect(los)
    Enum.map(los, fn(s) -> toTuple(s) end)
  end

  def toTuple(s) do
    if Enum.member?(["+", "-", "*", "/"], s) do
      {:operator, s}
    else
      {:number, parse_float(s)}
    end
  end

  def findMultiDiv([{:number, s1}, {:operator, "*"},
    {:number, s3} | rest]) do
    findMultiDiv([{:number, s1 * s3} | rest])
  end

  def findMultiDiv([{:number, s1}, {:operator, "/"},
    {:number, s3} | rest]) do
    findMultiDiv([{:number, s1 / s3} | rest])
  end

  def findMultiDiv([first | rest]) do
    [first] ++ findMultiDiv(rest)
  end

  def findMultiDiv([]) do
    []
  end

  def findPlusMi([{:number, s1}, {:operator, "+"},
    {:number, s3} | rest]) do
    findPlusMi([{:number, s1 + s3} | rest])
  end

  def findPlusMi([{:number, s1}, {:operator, "-"},
    {:number, s3} | rest]) do
    findPlusMi([{:number, s1 - s3} | rest])
  end

  def findPlusMi([first | rest]) do
    [first] ++ findMultiDiv(rest)
  end

  def findPlusMi([]) do
    []
  end

  def tupleToNum(num) do
    elem(num, 1)
  end

end
