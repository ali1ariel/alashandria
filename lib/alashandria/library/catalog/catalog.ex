defmodule Alashandria.Library.Catalog do
  use Ash.Domain,
    otp_app: :alashandria,
    extensions: [AshGraphql.Domain]

  alias Alashandria.Library.Catalog.Book
  alias Alashandria.Library.Catalog.Author
  alias Alashandria.Library.Catalog.Category

  graphql do
    authorize? false
    show_raised_errors? true
  end

  resources do
    resource Book do
      define :create_book, action: :create
    end
    resource Author do
      define :create_author, action: :create
    end
    resource Category do
      define :create_category, action: :create
    end
  end
end
