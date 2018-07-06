defmodule ChexDigits.Rules do
  @moduledoc """
  This module delegates the check_digit generator to the proper module for each data type.
  """
  alias __MODULE__

  def check_digit(digits, :cnpj), do: do_check_digit(digits, Rules.CNPJ)
  def check_digit(digits, :cpf), do: do_check_digit(digits, Rules.CPF)
  def check_digit(digits, :credit_card), do: do_check_digit(digits, Rules.CreditCard)

  def check_digit(digits, :banco_do_brasil),
    do: do_check_digit(digits, Rules.BankAccounts.BancoDoBrasil)

  def check_digit(digits, :banrisul), do: do_check_digit(digits, Rules.BankAccounts.Banrisul)
  def check_digit(digits, :bradesco), do: do_check_digit(digits, Rules.BankAccounts.Bradesco)
  def check_digit(digits, :caixa), do: do_check_digit(digits, Rules.BankAccounts.CaixaEconomica)
  def check_digit(digits, :citibank), do: do_check_digit(digits, Rules.BankAccounts.Citibank)
  def check_digit(digits, :hsbc), do: do_check_digit(digits, Rules.BankAccounts.HSBC)
  def check_digit(digits, :itau), do: do_check_digit(digits, Rules.BankAccounts.Itau)
  def check_digit(digits, :real), do: do_check_digit(digits, Rules.BankAccounts.Real)
  def check_digit(digits, :santander), do: do_check_digit(digits, Rules.BankAccounts.Santander)

  defp do_check_digit(digits, module), do: module.check_digit(digits)
end
