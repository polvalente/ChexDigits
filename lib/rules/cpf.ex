defmodule DigitValidator.Rules.Cpf do
  import DigitValidator.Helper
  import Enum, only: [to_list: 1]

  def verifier_digit(digits) do
    digits = Enum.take(digits, 9)

    first_vd =
      digits
      |> checksum(11, to_list(1..9), %{10 => 0})

    second_vd =
      digits ++ [first_vd]
      |> checksum(11, to_list(0..9), %{10 => 0})

    [first_vd, second_vd]
  end
end