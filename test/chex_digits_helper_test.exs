defmodule ChexDigits.HelperTest do
  @moduledoc """
  Unit tests for the Helper functions. This won't test the `checksum` function,
  as it is thoroughly tested via the Rule tests.
  """
  use ExUnit.Case, async: true

  import ChexDigits.Helper

  @moduletag :focus

  test "`to_list/1`" do
    assert [1, 2, 3, 4] = to_list("1234")
    assert [1, 2, 3, 4] = to_list([1, 2, 3, 4])
    assert {:error, _} = to_list(1)
  end

  test "`dot/4`" do
    assert 1 = dot([1, 2, 3], [1], & &1, :left)
    assert 3 = dot([1, 2, 3], [1, 1], & &1, :left)
    assert 6 = dot([1, 2, 3], [1, 1, 1], & &1, :left)

    assert 3 = dot([1, 2, 3], [1], & &1, :right)
    assert 5 = dot([1, 2, 3], [1, 1], & &1, :right)
    assert 6 = dot([1, 2, 3], [1, 1, 1], & &1, :right)

    assert 2 = dot([1, 2, 3], [1], &(2 * &1), :left)
    assert 6 = dot([1, 2, 3], [1, 1], &(2 * &1), :left)
    assert 12 = dot([1, 2, 3], [1, 1, 1], &(2 * &1), :left)

    assert 6 = dot([1, 2, 3], [1], &(2 * &1), :right)
    assert 10 = dot([1, 2, 3], [1, 1], &(2 * &1), :right)
    assert 12 = dot([1, 2, 3], [1, 1, 1], &(2 * &1), :right)

    assert 5 = dot([1, 2, 3, 4], [1, 2], & &1, :left)
    assert 11 = dot([1, 2, 3, 4], [1, 2], & &1, :right)
  end

  test "`map_onto/2`" do
    assert [1, 2, 3, 4, 5] = map_onto([1, "B", 3, 4, "E"], %{"B" => 2, "E" => 5})
  end
end
