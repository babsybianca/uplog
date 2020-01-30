"""
Author: Arian Allenson Valdez
This is a course requirement for CS 192
Software Engineering II under the
supervision of Asst. Prof. Ma. Rowena C.
Solamo of the Department of Computer
Science, College of Engineering, University
of the Philippines, Diliman for the AY 2019-
2020
Arian Allenson Valdez - 26/01/2020 - Scaffold
Arian Allenson Valdez - 28/01/2020 - Allow deleting of borrowable item, borrow as org
"""

defmodule UplogWeb.BorrowableItemController do
  use UplogWeb, :controller

  alias Uplog.Borrowables
  alias Uplog.Borrowables.BorrowableItem

  def index(conn, %{"organization_id" => organization_id}) do
    organization = Borrowables.get_organization!(organization_id)
    borrowable_items = Borrowables.list_borrowable_items(organization)
    user = Pow.Plug.current_user(conn)
    can_current_user_approve = Borrowables.is_user_organization_admin(user, organization)
    render(conn, "index.html", organization: organization, borrowable_items: borrowable_items, can_current_user_approve: can_current_user_approve)
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
    user = Pow.Plug.current_user(conn)
    organizations = Borrowables.get_user_organizations(user)
    render(conn, "show.html", organization: organization, borrowable_item: borrowable_item, organizations: organizations)
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

  def delete(conn, %{"organization_id" => organization_id, "id" => id}) do
    item = Borrowables.get_borrowable_item!(id)
    {:ok, _organization} = Borrowables.delete_borrowable_item(item)

    conn
    |> put_flash(:info, "Borrowable item deleted successfully.")
    |> redirect(to: Routes.organization_borrowable_item_path(conn, :index, organization_id))
  end
end
