defmodule Alashandria.Library.Circulation do
  use Ash.Domain,
    otp_app: :alashandria,
    extensions: [AshGraphql.Domain]

  alias Alashandria.Library.Circulation.Reserve

  graphql do
    authorize? false
    show_raised_errors? true
  end

  resources do
    resource Reserve
  end
end
