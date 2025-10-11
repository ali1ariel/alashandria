defmodule Alashandria.Library.Circulation.Reserve do
  use Ash.Resource,
    domain: Alashandria.Library.Circulation,
    data_layer: Ash.DataLayer.Mnesia,
    extensions: [AshGraphql.Resource]

  require Ash.Query

  alias Alashandria.Library.Catalog.Validations, as: CatalogValidations

  graphql do
    type :reserve

    queries do
      get :get_reserve, :read
      list :list_reserves, :read
      list :search_reserves, :search
    end

    mutations do
      create :create_reserve, :create
    end
  end

  actions do
    defaults [:read]

    read :search do
      argument :book_id, :string, allow_nil?: true
      # argument :user_id, :string, allow_nil?: true

      prepare fn query, _context ->
        query
        |> Ash.Query.filter(book_id: Ash.Query.get_argument(query, :book_id))

        # |> Ash.Query.filter(user_id: Ash.Query.get_argument(query, :user_id))
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

    attribute :was_canceled, :boolean do
      public? true
    end

    timestamps do
      public? true
    end
  end

  relationships do
    belongs_to :book, Alashandria.Library.Catalog.Book do
      public? true
      allow_nil? false
    end
  end
end
