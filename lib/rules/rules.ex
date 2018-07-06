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
        :santander -> Rules.BankAccounts.Santander
      end

    module.check_digit(digits)
  end
end