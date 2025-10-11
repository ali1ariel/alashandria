defmodule Alashandria.Library.Circulation.Loan do
  use Ash.Resource,
    domain: Alashandria.Library.Circulation,
    data_layer: Ash.DataLayer.Mnesia,
    extensions: [AshGraphql.Resource]

  require Ash.Query

  alias Alashandria.Library.Catalog.Validations, as: CatalogValidations

  graphql do
    type :loan

    queries do
      get :get_loan, :read
      list :list_loans, :read
      list :search_loans, :search
    end

    mutations do
      create :create_loan, :create
    end
  end

  actions do
    defaults [:read]

    read :search do
      argument :book_id, :string, allow_nil?: true

      prepare fn query, _context ->
        query
        |> Ash.Query.filter(book_id: Ash.Query.get_argument(query, :book_id))
      end
    end

    create :create do
      accept [:book_id]

      validate {CatalogValidations.BookExists, []}
    end
  end

  attributes do
    uuid_primary_key :id do
      public? true
    end

    create_timestamp :lent_at do
      public? true
    end

    attribute :expected_return_date, :date do
      public? true
      default &calc_return_date/0
      writable? true
    end

    attribute :returned_at, :utc_datetime_usec do
      public? true
      default nil
    end
  end

  relationships do
    belongs_to :reserve, Alashandria.Library.Circulation.Reserve do
      source_attribute :from_reserve_id
      public? true
      allow_nil? true
    end

    belongs_to :book, Alashandria.Library.Catalog.Book do
      public? true
      allow_nil? false
    end
  end

  defp calc_return_date() do
    today = Date.utc_today()
    Timex.shift(today, days: 7)
  end
end
