defmodule ChexDigits.CPFCNPJTest do
  use ExUnit.Case
  use ExUnitProperties

  def generate_cnpj, do: StreamData.map(StreamData.constant(false), &Brcpfcnpj.cnpj_generate/1)
  def generate_cpf, do: StreamData.map(StreamData.constant(false), &Brcpfcnpj.cpf_generate/1)

  property "Should always return valid CNPJ" do
    check all cnpj <- generate_cnpj() do
      [digit1, digit2] = ChexDigits.gen_check_digit(cnpj, :cnpj)
      assert String.slice(cnpj, -2..-1) == "#{digit1}#{digit2}"
    end
  end

  property "Should always return valid CPF" do
    check all cpf <- generate_cpf() do
      [digit1, digit2] = ChexDigits.gen_check_digit(cpf, :cpf)
      assert String.slice(cpf, -2..-1) == "#{digit1}#{digit2}"
    end
  end
end
