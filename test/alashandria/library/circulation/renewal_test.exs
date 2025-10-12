defmodule Alashandria.RenewalTest do
  use ExUnit.Case
  use Alashandria.Generator

  alias Alashandria.Library.Circulation

  test "success: create the renewal" do
    renewal = generate(renewal())

    loaded_renewal = Ash.load!(renewal, :loan)
    assert renewal.loan_id == loaded_renewal.loan.id
    assert not is_nil(renewal.renewed_at)
  end

  test "failed: try to create the renewal with no book" do
    changeset = Circulation.changeset_to_create_renewal(%{})

    Enum.map(changeset.errors, fn error ->
      case error do
        e = %Ash.Error.Changes.InvalidAttribute{} ->
          assert e.field == :loan_id and e.message =~ "Loan does not exist"

        e = %Ash.Error.Changes.Required{} ->
          assert e.field == :loan_id
      end
    end)

    refute changeset.valid?
  end
end
