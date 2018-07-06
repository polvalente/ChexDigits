defmodule CheckDigit.Rules.BankAgency do
  import CheckDigit.Helper
  import Enum, only: [to_list: 1]

  def check_digit(digits) do
    digits
    |> checksum(
      -11,
      sub(5, Enum.to_list(0..length(digits))),
      %{10 => "X"}
    )
    |> List.wrap()
  end
end