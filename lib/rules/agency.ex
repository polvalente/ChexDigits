defmodule DigitValidator.Rules.Agency do
  import DigitValidator.Helper
  import Enum, only: [to_list: 1]

  def verifier_digit(digits) do
    digits
    |> checksum(
      -11,
      sub(5, Enum.to_list(0..length(digits))),
      %{10 => "X"}
    )
    |> List.wrap()
  end
end