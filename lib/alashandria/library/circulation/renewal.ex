defmodule Alashandria.Library.Circulation.Renewal do
  use Ash.Resource,
    domain: Alashandria.Library.Circulation,
    data_layer: Ash.DataLayer.Mnesia,
    extensions: [AshGraphql.Resource]

  require Ash.Query

  graphql do
    type :renewal

    queries do
      get :get_renewal, :read
      list :list_renewals, :read
      list :search_renewals, :search
    end

    mutations do
      create :create_renewal, :create
    end
  end

  actions do
    defaults [:read]

    read :search do
      argument :loan_id, :string, allow_nil?: true

      prepare fn query, _context ->
        query
        |> Ash.Query.filter(loan_id: Ash.Query.get_argument(query, :loan_id))
      end
    end
  end

  attributes do
    uuid_primary_key :id do
      public? true
    end

    attribute :value, :decimal do
      public? true
    end

    attribute :type, :string do
      public? true
    end
  end

  relationships do
    belongs_to :loan, Alashandria.Library.Circulation.Loan do
      public? true
    end
  end
end
