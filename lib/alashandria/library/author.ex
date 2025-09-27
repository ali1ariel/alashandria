defmodule Alashandria.Library.Author do
  use Ash.Resource,
    domain: Alashandria.Library,
    data_layer: Ash.DataLayer.Mnesia,
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
      validate string_length(:nationality, min: 2, max: 2)

      validate match(:nationality, "^[A-Z]{2}$")
    end
  end

  attributes do
    uuid_primary_key :id

    attribute :name, :string do
      public? true
      filterable? true
    end

    attribute :bio, :string do
      public? true
    end

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

  # Mnesia doesn't have support for queries with partial strings, so this query fetch all data from the base and filter the results
  defp filter_by_name(query, search_term) do
    Ash.Query.after_action(query, fn _query, results ->
      filtered =
        Enum.filter(results, fn author ->
          author.name
          |> String.downcase()
          |> String.contains?(String.downcase(search_term))
        end)

      {:ok, filtered}
    end)
  end

  defp filter_by_nationality(query, nationality) when nationality in [nil, ""], do: query

  defp filter_by_nationality(query, nationality),
    do: Ash.Query.filter(query, nationality: nationality)
end
