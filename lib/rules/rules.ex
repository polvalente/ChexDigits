defmodule CheckDigit.Rules do
  alias __MODULE__

  def verifier_digit(digits, type) do
    module =
      case type do
        :cnpj -> Rules.CNPJ
        :cpf -> Rules.CPF
        :credit_card -> Rules.CreditCard
        :bank_agency -> Rules.BankAgency
      end

    module.check_digit(digits)
  end
end