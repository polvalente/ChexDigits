defmodule ChexDigits.Rules.CreditCard do
  @moduledoc false
  import ChexDigits.Helper
  import Enum, only: [to_list: 1]

  def check_digit(digits) do
    digits
    |> checksum(nil, two_one(length(digits)), %{}, 9)
    |> to_next_multiple_of(10)
    |> List.wrap()
  end
end
