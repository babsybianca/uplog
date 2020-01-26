defmodule UplogWeb.PageController do
  use UplogWeb, :controller

  def index(conn, _params) do
    render(conn, "index.html")
  end
end
