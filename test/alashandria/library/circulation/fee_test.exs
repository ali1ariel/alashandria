defmodule Alashandria.FeeTest do
  use ExUnit.Case
  use Alashandria.Generator

  alias Alashandria.Library.Circulation

  test "success: create the fee" do
    fee = generate(fee())

    loaded_fee = Ash.load!(fee, :loan)
    assert fee.loan_id == loaded_fee.loan.id
    assert not is_nil(fee.value)
  end

  test "failed: try to create the fee with no loan" do
    changeset = Circulation.changeset_to_create_fee(%{})

    Enum.map(changeset.errors, fn error ->
      case error do
        e = %Ash.Error.Changes.InvalidAttribute{} ->
          assert e.field == :loan_id and e.message in ["Loan does not exist"]

        e = %Ash.Error.Changes.Required{} ->
          assert e.field in [:loan_id, :value]
      end
    end)

    refute changeset.valid?
  end
end
