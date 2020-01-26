defmodule UplogWeb.BorrowRequestController do
  use UplogWeb, :controller

  alias Uplog.Borrowables
  alias Uplog.Borrowables.BorrowRequest

  def index(conn, _params) do
    borrow_requests = Borrowables.list_borrow_requests()
    render(conn, "index.html", borrow_requests: borrow_requests)
  end

  def new(conn, _params) do
    changeset = Borrowables.change_borrow_request(%BorrowRequest{})
    render(conn, "new.html", changeset: changeset)
  end

  def create(conn, %{"borrow_request" => borrow_request_params}) do
    case Borrowables.create_borrow_request(borrow_request_params) do
      {:ok, borrow_request} ->
        conn
        |> put_flash(:info, "Borrow request created successfully.")
        |> redirect(to: Routes.borrow_request_path(conn, :show, borrow_request))

      {:error, %Ecto.Changeset{} = changeset} ->
        render(conn, "new.html", changeset: changeset)
    end
  end

  def show(conn, %{"id" => id}) do
    borrow_request = Borrowables.get_borrow_request!(id)
    render(conn, "show.html", borrow_request: borrow_request)
  end

  def edit(conn, %{"id" => id}) do
    borrow_request = Borrowables.get_borrow_request!(id)
    changeset = Borrowables.change_borrow_request(borrow_request)
    render(conn, "edit.html", borrow_request: borrow_request, changeset: changeset)
  end

  def update(conn, %{"id" => id, "borrow_request" => borrow_request_params}) do
    borrow_request = Borrowables.get_borrow_request!(id)

    case Borrowables.update_borrow_request(borrow_request, borrow_request_params) do
      {:ok, borrow_request} ->
        conn
        |> put_flash(:info, "Borrow request updated successfully.")
        |> redirect(to: Routes.borrow_request_path(conn, :show, borrow_request))

      {:error, %Ecto.Changeset{} = changeset} ->
        render(conn, "edit.html", borrow_request: borrow_request, changeset: changeset)
    end
  end

  def delete(conn, %{"id" => id}) do
    borrow_request = Borrowables.get_borrow_request!(id)
    {:ok, _borrow_request} = Borrowables.delete_borrow_request(borrow_request)

    conn
    |> put_flash(:info, "Borrow request deleted successfully.")
    |> redirect(to: Routes.borrow_request_path(conn, :index))
  end
end
