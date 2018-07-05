defmodule DigitValidator.Rules do
  alias __MODULE__

  def verifier_digit(digits, type) do
    type =
      type
      |> Atom.to_string()
      |> Macro.camelize()

    Elixir.Module.concat(Rules, type).verifier_digit(digits)
  end
end