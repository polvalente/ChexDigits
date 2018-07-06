defmodule CheckDigit.Rules do
  alias __MODULE__

  def verifier_digit(digits, type) do
    module =
      case type do
        :cnpj -> Rules.CNPJ
        :cpf -> Rules.CPF
        :credit_card -> Rules.CreditCard
        :banco_do_brasil -> Rules.BankAccounts.BancoDoBrasil
      end

    module.check_digit(digits)
  end
end