defmodule ChexDigits.Rules.BankAccounts.Itau do
  @moduledoc false
  alias ChexDigits.Rule
  alias ChexDigits.Helper, as: H

  def rule(account, agency) do
    # Rule.new(
    #   H.to_list(agency) ++ H.pad(H.to_list(account), 5, :left),
    #   9,
    #   :left,
    #   -10,
    #   H.two_one(9),
    #   H.replacements(%{0 => 0}, %{}),
    #   fn term ->
    #     term
    #     |> Integer.to_string()
    #     |> String.split("", trim: true)
    #     |> Enum.reduce(0, &(&2 + String.to_integer(&1)))
    #   end
    # )
    weights =
      [2, 1]
      |> Stream.cycle()
      |> Enum.take(9)

    Rule.new(
      H.to_list(agency) ++ H.pad(H.to_list(account), 5, :left),
      %{},
      %{10 => 0},
      10,
      :module_minus,
      weights,
      :left,
      fn term ->
        term
        |> Integer.to_string()
        |> String.split("", trim: true)
        |> Enum.reduce(0, &(&2 + String.to_integer(&1)))
      end
    )
  end

  def execute(rule), do: H.checksum(rule)
end
