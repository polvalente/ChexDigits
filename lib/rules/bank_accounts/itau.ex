defmodule ChexDigits.Rules.BankAccounts.Itau do
  @moduledoc false
  import ChexDigits.Helper
  import Enum, only: [to_list: 1]

  def check_digit(digits) do
    digits
    |> pad(9, :left)
    |> checksum(
      -10,
      two_one(9),
      replacements(%{0 => 0}, %{}),
      9
    )
    |> List.wrap()
  end
end
