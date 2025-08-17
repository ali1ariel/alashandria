defmodule Alashandria.Library.Author do
  use Ash.Resource,
    domain: Alashandria.Library,
    data_layer: Ash.DataLayer.Ets,
    extensions: [AshGraphql.Resource]

  require Ash.Query

  graphql do
    type :author

    queries do
      get :get_author, :read

      list :list_authors, :read

      list :search_authors, :search
    end

    mutations do
      create :create_author, :create
    end
  end

  actions do
    defaults [:read]

    read :search do
      argument :name, :string, allow_nil?: true
      argument :nationality, :string, allow_nil?: true

      prepare fn query, _context ->
        query
        |> filter_by_name(Ash.Query.get_argument(query, :name))
        |> filter_by_nationality(Ash.Query.get_argument(query, :nationality))
      end
    end

    create :create do
      accept [:name, :bio, :birth_date, :death_date, :nationality]

      validate present([:name])
      validate string_length(:name, min: 2, max: 100)
    end
  end

  attributes do
    uuid_primary_key :id

    attribute :name, :string do
      public? true
      # filterable? true
    end

    attribute :bio, :string
    attribute :birth_date, :date
    attribute :death_date, :date

    attribute :nationality, :string do
      public? true
    end

    timestamps()
  end

  relationships do
    has_many :books, Alashandria.Library.Book
  end

  defp filter_by_name(query, name) when name in [nil, ""], do: query
  defp filter_by_name(query, name), do: Ash.Query.filter(query, name: name)

  defp filter_by_nationality(query, nationality) when nationality in [nil, ""], do: query

  defp filter_by_nationality(query, nationality),
    do: Ash.Query.filter(query, nationality: nationality)
end
