defmodule Alashandria.Library.Access do
  use Ash.Domain,
    otp_app: :alashandria,
    extensions: [AshGraphql.Domain]

  graphql do
    authorize? false
    show_raised_errors? true
  end

  resources do
  end
end
