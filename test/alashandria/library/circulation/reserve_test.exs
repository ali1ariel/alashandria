defmodule Alashandria.ReserveTest do
  use ExUnit.Case
  use Alashandria.Generator

  alias Alashandria.Library.Circulation

  test "success: create the reserve" do
    reserve = generate(reserve())

    loaded_reserve = Ash.load!(reserve, :book)
    assert reserve.book_id == loaded_reserve.book.id
  end

  test "failed: try to create the reserve with no book" do
    changeset = Circulation.changeset_to_create_reserve(%{})

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
