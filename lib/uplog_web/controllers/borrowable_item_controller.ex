defmodule UplogWeb.BorrowableItemController do
  use UplogWeb, :controller

  alias Uplog.Borrowables
  alias Uplog.Borrowables.BorrowableItem

  def index(conn, _params) do
    borrowable_items = Borrowables.list_borrowable_items()
    render(conn, "index.html", borrowable_items: borrowable_items)
  end

  def new(conn, _params) do
    changeset = Borrowables.change_borrowable_item(%BorrowableItem{})
    render(conn, "new.html", changeset: changeset)
  end

  def create(conn, %{"borrowable_item" => borrowable_item_params}) do
    case Borrowables.create_borrowable_item(borrowable_item_params) do
      {:ok, borrowable_item} ->
        conn
        |> put_flash(:info, "Borrowable item created successfully.")
        |> redirect(to: Routes.borrowable_item_path(conn, :show, borrowable_item))

      {:error, %Ecto.Changeset{} = changeset} ->
        render(conn, "new.html", changeset: changeset)
    end
  end

  def show(conn, %{"id" => id}) do
    borrowable_item = Borrowables.get_borrowable_item!(id)
    render(conn, "show.html", borrowable_item: borrowable_item)
  end

  def edit(conn, %{"id" => id}) do
    borrowable_item = Borrowables.get_borrowable_item!(id)
    changeset = Borrowables.change_borrowable_item(borrowable_item)
    render(conn, "edit.html", borrowable_item: borrowable_item, changeset: changeset)
  end

  def update(conn, %{"id" => id, "borrowable_item" => borrowable_item_params}) do
    borrowable_item = Borrowables.get_borrowable_item!(id)

    case Borrowables.update_borrowable_item(borrowable_item, borrowable_item_params) do
      {:ok, borrowable_item} ->
        conn
        |> put_flash(:info, "Borrowable item updated successfully.")
        |> redirect(to: Routes.borrowable_item_path(conn, :show, borrowable_item))

      {:error, %Ecto.Changeset{} = changeset} ->
        render(conn, "edit.html", borrowable_item: borrowable_item, changeset: changeset)
    end
  end

  def delete(conn, %{"id" => id}) do
    borrowable_item = Borrowables.get_borrowable_item!(id)
    {:ok, _borrowable_item} = Borrowables.delete_borrowable_item(borrowable_item)

    conn
    |> put_flash(:info, "Borrowable item deleted successfully.")
    |> redirect(to: Routes.borrowable_item_path(conn, :index))
  end
end
