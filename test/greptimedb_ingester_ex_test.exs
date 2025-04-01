defmodule GreptimexTest do
  use ExUnit.Case
  doctest Greptimex

  test "greets the world" do
    assert Greptimex.hello() == :world
  end
end
