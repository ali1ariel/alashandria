defmodule Alashandria.Library.Circulation.Reserve do
  use Ash.Resource,
    domain: Alashandria.Library.Circulation,
    data_layer: Ash.DataLayer.Mnesia,
    extensions: [AshGraphql.Resource]

  require Ash.Query

  graphql do
  end

  mutations do
  end

  actions do
  end

  attributes do
    uuid_primary_key :id do
      public? true
    end

    boolean :was_canceled? do
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
