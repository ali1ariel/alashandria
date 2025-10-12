defmodule Alashandria.Circulation.Generators do
  alias Alashandria.Library.Circulation.Fee
  alias Alashandria.Library.Circulation.Renewal
  alias Alashandria.Library.Circulation.Loan
  alias Alashandria.Catalog.Generators, as: CatalogGenerators
  alias Alashandria.Library.Circulation.Reserve
  use Ash.Generator

  def reserve(opts \\ []) do
    book_id =
      opts[:book_id] || once(:default_book_id, fn -> generate(CatalogGenerators.book()).id end)

    changeset_generator(
      Reserve,
      :create,
      defaults: [
        book_id: book_id
      ],
      overrides: opts
    )
  end

  def loan(opts \\ []) do
    reserve_id = opts[:reserve_id] || nil

    book_id =
      opts[:book_id] || once(:default_book_id, fn -> generate(CatalogGenerators.book()).id end)

    changeset_generator(
      Loan,
      :create,
      defaults: [
        reserve_id: reserve_id,
        book_id: book_id
      ],
      overrides: opts
    )
  end

  def renewal(opts \\ []) do
    loan_id = opts[:loan_id] || once(:default_loan_id, fn -> generate(loan()).id end)

    changeset_generator(
      Renewal,
      :create,
      defaults: [
        loan_id: loan_id
      ],
      overrides: opts
    )
  end

  def fee(opts \\ []) do
    loan_id = opts[:loan_id] || once(:default_loan_id, fn -> generate(loan()).id end)

    changeset_generator(
      Fee,
      :create,
      defaults: [
        loan_id: loan_id,
        value: 2.0
      ],
      overrides: opts
    )
  end
end
