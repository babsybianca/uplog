defmodule UplogWeb.PageController do
  use UplogWeb, :controller

  def index(conn, _params) do
    borrowable_items = Uplog.Borrowables.list_borrowable_items()
    render(conn, "index.html", borrowable_items: borrowable_items)
  end
end
