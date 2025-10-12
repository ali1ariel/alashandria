defmodule Alashandria.Library.Catalog.Book do
  use Ash.Resource,
    domain: Alashandria.Library.Catalog,
    data_layer: Ash.DataLayer.Mnesia,
    extensions: [AshGraphql.Resource]

  alias Alashandria.Library.Catalog.Validations
  alias Alashandria.Library.Catalog

  graphql do
    type :book

    queries do
      get :get_book, :read
      list :list_books, :read
      list :search_books, :search
    end

    mutations do
      create :create_book, :create
    end
  end

  actions do
    defaults [:read]

    read :search do
      argument :name, :string, allow_nil?: true
      argument :author, :string, allow_nil?: true

      prepare fn query, _context ->
        query
        |> filter_by_book_name(Ash.Query.get_argument(query, :name))
        |> filter_by_author_name(Ash.Query.get_argument(query, :author))
      end
    end

    create :create do
      accept [:name, :pages, :edition, :author_id, :category_id]
      validate present([:name, :pages, :edition, :author_id, :category_id])
      validate numericality(:pages, greater_than: 0)
      validate numericality(:edition, greater_than: 0)
      validate {Validations.AuthorExists, []}
      validate {Validations.CategoryExists, []}
    end
  end

  attributes do
    uuid_primary_key :id do
      public? true
    end

    attribute :name, :string do
      public? true
    end

    attribute :pages, :integer do
      public? true
    end

    attribute :edition, :integer do
      public? true
    end

    attribute :description, :string do
      public? true
    end

    attribute :isbn, :string do
      public? true
    end

    attribute :language, :string do
      default "PT"
      public? true
    end

    attribute :total_copies, :integer do
      default 1
      public? true
    end

    timestamps()
  end

  relationships do
    belongs_to :author, Alashandria.Library.Catalog.Author do
      public? true
      allow_nil? false
    end

    belongs_to :category, Alashandria.Library.Catalog.Category do
      public? true
      allow_nil? false
    end
  end

  defp filter_by_book_name(query, name) when name in [nil, ""], do: query

  # Mnesia doesn't have support for queries with partial strings, so this query fetch all data from the base and filter the results
  defp filter_by_book_name(query, search_term) do
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

  defp filter_by_author_name(query, name) when name in [nil, ""], do: query

  # Mnesia doesn't have support for queries with partial strings, so this query fetch all data from the base and filter the results
  defp filter_by_author_name(query, search_term) do
    query
    |> Ash.Query.after_action(fn _query, results ->
      loaded_books = Ash.load!(results, :author, domain: Catalog)

      filtered =
        Enum.filter(loaded_books, fn book ->
          case book.author do
            nil ->
              false

            author ->
              author.name
              |> String.downcase()
              |> String.contains?(String.downcase(search_term))
          end
        end)

      {:ok, filtered}
    end)
  end

 end
