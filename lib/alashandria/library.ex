defmodule Alashandria.Library do
  use Ash.Domain,
    otp_app: :alashandria,
    extensions: [AshGraphql.Domain]

  alias Alashandria.Library.Book
  alias Alashandria.Library.Author

  graphql do
    authorize? false
    show_raised_errors? true
  end

  resources do
    resource Book
    resource Author
  end
end
