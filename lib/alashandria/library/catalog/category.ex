defmodule Alashandria.Library.Catalog.Category do
  use Ash.Resource,
    domain: Alashandria.Library.Catalog,
    data_layer: Ash.DataLayer.Mnesia,
    extensions: [AshGraphql.Resource]

  require Ash.Query

  graphql do
    type :category

    queries do
      get :get_category, :read
      list :list_categories, :read
      list :search_categories, :search
    end

    mutations do
      create :create_category, :create
    end
  end

  actions do
    defaults [:read]

    read :search do
      argument :name, :string, allow_nil?: false

      prepare fn query, _context ->
        query
        |> Ash.Query.filter(name: Ash.Query.get_argument(query, :name))
      end
    end

    create :create do
      accept [:name]
    end
  end

  attributes do
    uuid_primary_key :id do
      public? true
    end

    attribute :name, :string do
      public? true
    end

    timestamps do
      public? true
    end
  end

  relationships do
    has_many :books, Alashandria.Library.Catalog.Book do
      public? true
    end
  end

  identities do
    identity :name, [:name] do
      pre_check_with Alashandria.Library
    end
  end
end
