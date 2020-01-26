defmodule UplogWeb.BorrowableItemController do
  use UplogWeb, :controller

  alias Uplog.Borrowables
  alias Uplog.Borrowables.BorrowableItem

  def index(conn, %{"organization_id" => organization_id}) do
    organization = Borrowables.get_organization!(organization_id)
    borrowable_items = Borrowables.list_borrowable_items(organization)
    render(conn, "index.html", organization: organization, borrowable_items: borrowable_items)
  end

  def new(conn, %{"organization_id" => organization_id}) do
    organization = Borrowables.get_organization!(organization_id)
    changeset = Borrowables.change_borrowable_item(%BorrowableItem{})
    render(conn, "new.html", organization: organization, changeset: changeset)
  end

  def create(conn, %{"organization_id" => organization_id, "borrowable_item" => borrowable_item_params}) do
    organization = Borrowables.get_organization!(organization_id)
    case Borrowables.create_borrowable_item(organization, borrowable_item_params) do
      {:ok, borrowable_item} ->
        conn
        |> put_flash(:info, "Borrowable item created successfully.")
        |> redirect(to: Routes.organization_borrowable_item_path(conn, :show, organization.id, borrowable_item))

      {:error, %Ecto.Changeset{} = changeset} ->
        render(conn, "new.html", organization: organization, changeset: changeset)
    end
  end

  def show(conn, %{"organization_id" => organization_id, "id" => id}) do
    organization = Borrowables.get_organization!(organization_id)
    borrowable_item = Borrowables.get_borrowable_item!(id)
    render(conn, "show.html", organization: organization, borrowable_item: borrowable_item)
  end

  def edit(conn, %{"organization_id" => organization_id, "id" => id}) do
    organization = Borrowables.get_organization!(organization_id)
    borrowable_item = Borrowables.get_borrowable_item!(id)
    changeset = Borrowables.change_borrowable_item(borrowable_item)
    render(conn, "edit.html", organization: organization, borrowable_item: borrowable_item, changeset: changeset)
  end

  def update(conn, %{"organization_id" => organization_id, "id" => id, "borrowable_item" => borrowable_item_params}) do
    borrowable_item = Borrowables.get_borrowable_item!(id)

    case Borrowables.update_borrowable_item(borrowable_item, borrowable_item_params) do
      {:ok, borrowable_item} ->
        conn
        |> put_flash(:info, "Borrowable item updated successfully.")
        |> redirect(to: Routes.organization_borrowable_item_path(conn, :show, organization_id, borrowable_item))

      {:error, %Ecto.Changeset{} = changeset} ->
        render(conn, "edit.html", borrowable_item: borrowable_item, changeset: changeset)
    end
  end
end
