defmodule ChexDigits.Rules do
  alias __MODULE__

  def check_digit(digits, type) do
    module =
      case type do
        :cnpj -> Rules.CNPJ
        :cpf -> Rules.CPF
        :credit_card -> Rules.CreditCard
        :banco_do_brasil -> Rules.BankAccounts.BancoDoBrasil
        :banrisul -> Rules.BankAccounts.Banrisul
        :bradesco -> Rules.BankAccounts.Bradesco
        :caixa -> Rules.BankAccounts.CaixaEconomica
        :citibank -> Rules.BankAccounts.Citibank
        :hsbc -> Rules.BankAccounts.HSBC
        :itau -> Rules.BankAccounts.Itau
        :real -> Rules.BankAccounts.Real
        :santander -> Rules.BankAccounts.Santander
      end

    module.check_digit(digits)
  end
end