defmodule ChexDigits do
  @moduledoc """
  This is the main module for the library.
  It delegates the check_digit generator to the proper module for each data type.
  """
  alias __MODULE__

  @banks [
    :banco_do_brasil,
    :banrisul,
    :bradesco,
    :caixa_economica,
    :citibank,
    :itau,
    :real,
    :santander
  ]
  @tax_ids [:cpf, :cnpj]

  def check_digit(digits, type) when type in @tax_ids do
    module =
      type
      |> Atom.to_string()
      |> String.upcase()

    module =
      __MODULE__
      |> Module.concat(Rules)
      |> Module.concat(module)

    digits
    |> module.rule()
    |> module.execute()
  end

  def check_digit(agency, account, :hsbc),
    do: do_check_digit_bank(agency, account, __MODULE__.Rules.BankAccounts.HSBC)

  def check_digit(agency, account, bank) when bank in @banks do
    module =
      Module.concat(
        __MODULE__.Rules.BankAccounts,
        Macro.camelize(to_string(bank))
      )

    do_check_digit_bank(agency, account, module)
  end

  defp do_check_digit_bank(agency, account, module) do
    account = String.replace(account, ~r/\D.*/, "")
    agency = String.replace(agency, ~r/\D.*/, "")

    account
    |> module.rule(agency)
    |> module.execute()
  end
end
