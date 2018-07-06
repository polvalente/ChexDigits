defmodule CheckDigit.Rules.CNPJ do
  import CheckDigit.Helper
  import Enum, only: [to_list: 1]

  def check_digit(digits) do
    gen_check_digit(digits, :cnpj_last)
  end

  def gen_check_digit(digits, :cnpj_last) do
    first_vd =
      digits
      |> Enum.take(13)
      |> checksum(11, to_list(6..9) ++ to_list(2..9), %{10 => 0})

      second_vd =
      digits ++ [first_vd]
      |> checksum(11, to_list(5..9) ++ to_list(2..9), %{10 => 0})

      [first_vd, second_vd]
  end

  def gen_check_digit(digits, :cnpj_eighth) do
    digits
    |> Enum.take(7)
    |> checksum(10, two_one(7), %{10 => 0}, 9)
    |> to_next_multiple_of(10)
    |> List.wrap()
  end
end