defmodule Alashandria.Library do
  use Ash.Domain,
    otp_app: :alashandria

  resources do
    resource Alashandria.Library.Book
    resource Alashandria.Library.Author
  end
end
