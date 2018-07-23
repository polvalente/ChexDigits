defmodule ChexDigits.CPFCNPJTest do
  use ExUnit.Case
  use ExUnitProperties

  def generate_cnpj, do: StreamData.map(StreamData.constant(false), &Brcpfcnpj.cnpj_generate/1)
  def generate_cpf, do: StreamData.map(StreamData.constant(false), &Brcpfcnpj.cpf_generate/1)

  property "Should always return valid CNPJ" do
    check all cnpj <- generate_cnpj() do
      cnpj = String.codepoints(cnpj)

      check_digits =
        cnpj
        |> Enum.take(-2)

      digits =
        cnpj
        |> Enum.take(12)

      assert check_digits == ChexDigits.check_digit(digits, :cnpj)
    end
  end

  property "Should always return valid CPF" do
    check all cpf <- generate_cpf() do
      cpf = String.codepoints(cpf)

      check_digits =
        cpf
        |> Enum.take(-2)

      digits =
        cpf
        |> Enum.take(9)

      assert check_digits = ChexDigits.check_digit(digits, :cpf)
    end
  end
end
