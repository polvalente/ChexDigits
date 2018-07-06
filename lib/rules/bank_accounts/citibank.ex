defmodule ChexDigits.Rules.BankAccounts.Citibank do
  @moduledoc false
  import ChexDigits.Helper
  import Enum, only: [to_list: 1]

  def check_digit(digits) do
    digits
    |> pad(10, :left)
    |> checksum(
      -11,
      to_list(11..2),
      replacements(%{0 => 0, 1 => 0}, %{})
    )
    |> List.wrap()
  end
end
