defmodule ChexDigits.Rules.BankAccounts.HSBC do
  @moduledoc false
  import ChexDigits.Helper
  import Enum, only: [to_list: 1]

  def check_digit(digits) do
    digits
    |> pad(10, :left)
    |> checksum(
      11,
      [8, 9, 2, 3, 4, 5, 6, 7, 8, 9],
      replacements(%{0 => 0, 10 => 0}, %{})
    )
    |> List.wrap()
  end
end
