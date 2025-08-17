defmodule Alashandria.Library.Author do
  use Ash.Resource,
    domain: Alashandria.Library,
    data_layer: Ash.DataLayer.Ets

  actions do
    defaults [:read]

    create :create do
      accept [:name, :bio, :birth_date, :death_date, :nationality]

      validate present([:name])
      validate string_length(:name, min: 2, max: 100)
    end
  end

  attributes do
    uuid_primary_key :id

    attribute :name, :string
    attribute :bio, :string
    attribute :birth_date, :date
    attribute :death_date, :date
    attribute :nationality, :string

    timestamps()
  end

  relationships do
    has_many :books, Alashandria.Library.Book
  end
end
