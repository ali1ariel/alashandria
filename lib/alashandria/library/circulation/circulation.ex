defmodule Alashandria.Library.Circulation do
  use Ash.Domain,
    otp_app: :alashandria,
    extensions: [AshGraphql.Domain]

  alias Alashandria.Library.Circulation.{Reserve, Loan, Fee, Renewal}

  graphql do
    authorize? false
    show_raised_errors? true
  end

  resources do
    resource Reserve do
      define :create_reserve, action: :create
    end

    resource Loan do
      define :create_loan, action: :create
    end

    resource Fee do
      define :create_fee, action: :create
    end

    resource Renewal do
      define :create_renewal, action: :create
    end
  end
end
