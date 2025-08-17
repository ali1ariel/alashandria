defmodule Alashandria.Library do
  use Ash.Domain,
    otp_app: :alashandria,
    extensions: [AshGraphql.Domain]

  alias Alashandria.Library.Book
  alias Alashandria.Library.Author

  resources do
    resource Book
    resource Author
  end

  graphql do
    authorize? false
    show_raised_errors? true
  end

end
