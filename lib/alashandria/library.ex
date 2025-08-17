defmodule Alashandria.Library do
  use Ash.Domain,
    otp_app: :alashandria

  alias Alashandria.Library.Book
  alias Alashandria.Library.Author

  resources do
    resource Book
    resource Author
  end
end
