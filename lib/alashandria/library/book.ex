defmodule Alashandria.Library.Book do
  use Ash.Resource,
    domain: Alashandria.Library,
    data_layer: Ash.DataLayer.Ets

  actions do
    defaults [:read]

    create :create do
      accept [:name, :pages, :edition, :author_id]
    end
  end

  attributes do
    uuid_primary_key :id

    attribute :name, :string
    attribute :pages, :integer
    attribute :edition, :integer
    attribute :isbn, :string
    attribute :description, :string
    attribute :language, :string, default: "pt"
    attribute :total_copies, :integer, default: 1

    timestamps()
  end

  relationships do
    belongs_to :author, Alashandria.Library.Author
  end

end
