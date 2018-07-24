defmodule ChexDigits.Rules.BankAccounts.CaixaEconomica do
  @moduledoc false
  alias ChexDigits.Rule
  alias ChexDigits.Helper, as: H
  import Enum, only: [to_list: 1]

  def rule(account, agency) do
    # Rule.new(
    #   H.to_list(agency) ++ H.pad(H.to_list(account), 11, :left),
    #   15,
    #   :left,
    #   -11,
    #   to_list(8..2) ++ to_list(9..2),
    #   H.replacements(%{0 => 0}, %{10 => 0})
    # )

    Rule.new(
      H.to_list(agency) ++ H.pad(H.to_list(account), 11, :left),
      %{},
      %{11 => 0, 10 => 0},
      11,
      :module_minus,
      to_list(8..2) ++ to_list(9..2),
      :left
    )
  end

  def execute(rule), do: H.checksum(rule)
end
