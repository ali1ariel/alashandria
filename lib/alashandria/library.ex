defmodule Alashandria.Library do
  use Ash.Domain,
    otp_app: :alashandria,
    extensions: [AshGraphql.Domain]

  alias Alashandria.Library.Book
  alias Alashandria.Library.Author
  alias Alashandria.Library.Category

  graphql do
    authorize? false
    show_raised_errors? true
  end

  resources do
    resource Book
    resource Author
    resource Category
  end
end
