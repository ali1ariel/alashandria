defmodule Alashandria.LoanTest do
  use ExUnit.Case
  use Alashandria.Generator

  alias Alashandria.Library.Circulation

  test "success: create the loan" do
    loan = generate(loan())

    loaded_loan = Ash.load!(loan, :book)
    assert loan.book_id == loaded_loan.book.id
    assert not is_nil(loan.expected_return_date)
  end

  test "failed: try to create the loan with no book" do
    changeset = Circulation.changeset_to_create_loan(%{})

    Enum.map(changeset.errors, fn error ->
      case error do
        e = %Ash.Error.Changes.InvalidAttribute{} ->
          assert e.field == :book_id and e.message =~ "Book does not exist"

        e = %Ash.Error.Changes.Required{} ->
          assert e.field == :book_id
      end
    end)

    refute changeset.valid?
  end
end
