defmodule DigitValidator.Rules do
  import DigitValidator.Helper
  import Enum, only: [to_list: 1]

  def gen_vd(digits, :cpf) do
    first_vd =
      digits
      |> Enum.take(9)
      |> checksum(11, to_list(10..2), %{10 => 0})

    second_vd =
      [digits | first_vd]
      |> checksum(11, to_list(11..2), %{10 => 0})

    [first_vd, second_vd]
  end

end