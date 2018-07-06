defmodule ChexDigits.Rules.CPF do
  @moduledoc false
  import ChexDigits.Helper
  import Enum, only: [to_list: 1]

  def check_digit(digits) do
    digits = Enum.take(digits, 9)

    first_vd =
      digits
      |> checksum(-11, to_list(10..2), %{1 => 0})

    second_vd =
      (digits ++ [first_vd])
      |> checksum(-11, to_list(11..2), %{1 => 0})

    [first_vd, second_vd]
  end
end
