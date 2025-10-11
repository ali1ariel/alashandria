defmodule Alashandria.Library.Circulation.Fee do
  use Ash.Resource,
    domain: Alashandria.Library.Circulation,
    data_layer: Ash.DataLayer.Mnesia,
    extensions: [AshGraphql.Resource]

  require Ash.Query

  graphql do
    type :fee

    queries do
      get :get_fee, :read
      list :list_fees, :read
      list :search_fees, :search
    end

    mutations do
      create :create_fee, :create
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

    create :create do
      accept [:value, :type, :loan_id]
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

    attribute :paid, :boolean do
      public? true
    end

    attribute :paid_at, :utc_datetime_usec do
      public? true
      default nil
    end
  end

  relationships do
    belongs_to :loan, Alashandria.Library.Circulation.Loan do
      public? true
    end
  end
end
