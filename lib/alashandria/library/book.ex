defmodule Alashandria.Library.Book do
  use Ash.Resource,
    domain: Alashandria.Library,
    data_layer: Ash.DataLayer.Ets,
    extensions: [AshGraphql.Resource]

  graphql do
    type :book

    queries do
      get :get_book, :read
      list :list_books, :read
    end

    mutations do
      create :create_book, :create
    end
  end

  actions do
    defaults [:read]

    create :create do
      accept [:name, :pages, :edition, :author_id]
      validate present([:name, :pages, :edition, :author_id])
      validate numericality(:pages, greater_than: 0)
      validate numericality(:edition, greater_than: 0)
    end
  end

  attributes do
    uuid_primary_key :id

    attribute :name, :string do
      public? true
    end
    attribute :pages, :integer
    attribute :edition, :integer do
      public? true
    end
    attribute :isbn, :string
    attribute :description, :string
    attribute :language, :string, default: "pt"
    attribute :total_copies, :integer, default: 1

    timestamps()
  end

  relationships do
    belongs_to :author, Alashandria.Library.Author do
      public? true
    end
  end

end
