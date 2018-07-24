defmodule ChexDigits.BankAccountsTest do
  use ExUnit.Case
  use ExUnitProperties

  def generate(bank) do
    {:ok, content} = File.read("test/support/bank_accounts/" <> bank <> ".json")
    {:ok, data} = Poison.decode(content)

    StreamData.member_of(data)
  end

  property "Itau bank account validation" do
    check all data <- generate("itau") do
      assert ChexDigits.check_digit(data["agency"], data["account"], :itau)
    end
  end

  property "Banco do Brasil bank account validation" do
    check all data <- generate("banco_do_brasil") do
      assert ChexDigits.check_digit(data["agency"], data["account"], :banco_do_brasil)
    end
  end

  property "Caixa Economica bank account validation" do
    check all data <- generate("caixa_economica") do
      assert ChexDigits.check_digit(data["agency"], data["account"], :caixa_economica)
    end
  end

  @tag :focus
  property "Citibank bank account validation" do
    check all data <- generate("citibank") do
      assert ChexDigits.check_digit(data["agency"], data["account"], :citibank)
    end
  end

  property "HSBC bank account validation" do
    check all data <- generate("hsbc") do
      assert ChexDigits.check_digit(data["agency"], data["account"], :hsbc)
    end
  end

  property "Santander bank account validation" do
    check all data <- generate("santander") do
      assert ChexDigits.check_digit(data["agency"], data["account"], :santander)
    end
  end
end
