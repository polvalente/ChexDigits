defmodule ChexDigits.Rules.CPF do
  @moduledoc false
  alias ChexDigits.Types.Rule
  alias ChexDigits.Helper, as: H
  import Enum, only: [to_list: 1]

  def check_digits(digits) do
    digits =
      digits
      |> H.to_list()
      |> Enum.take(9)

    first_cd =
      digits
      |> rule()
      |> execute()

    second_cd =
      (digits ++ [first_cd])
      |> rule()
      |> execute()

    [first_cd, second_cd]
  end

  def rule(digits) do
    Rule.new(
      digits,
      10,
      :left,
      -11,
      to_list(11..2),
      H.replacements(%{1 => 0, 0 => 0}, %{})
    )
  end

  def execute(rule), do: H.checksum(rule)
end
