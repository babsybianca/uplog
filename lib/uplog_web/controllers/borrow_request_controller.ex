"""
Author: Arian Allenson Valdez
This is a course requirement for CS 192
Software Engineering II under the
supervision of Asst. Prof. Ma. Rowena C.
Solamo of the Department of Computer
Science, College of Engineering, University
of the Philippines, Diliman for the AY 2019-
2020
Arian Allenson Valdez - 26/01/2020 -
Scaffold, Pass properties to templates, Add approve/deny methods
Arian Allenson Valdez - 28/01/2020 -
Fix bug with double borrowing, Add borrowing as org
"""

defmodule UplogWeb.BorrowRequestController do
  use UplogWeb, :controller

  alias Uplog.Borrowables
  alias Uplog.Borrowables.BorrowRequest

  def index(conn, %{"organization_id" => organization_id, "borrowable_item_id" => item_id}) do
    organization = Borrowables.get_organization!(organization_id)
    borrowable_item = Borrowables.get_borrowable_item!(item_id)
    borrow_requests = Borrowables.list_borrow_requests(organization_id)
    render(conn, "index.html", organization: organization, borrowable_item: borrowable_item, borrow_requests: borrow_requests)
  end

  def create(conn, %{"organization_id" => organization_id, "borrowable_item_id" => item_id, "borrower_organization_id" => borrower_organization_id}) do
    organization = Borrowables.get_organization!(organization_id)
    borrowable_item = Borrowables.get_borrowable_item!(item_id)
    user = Pow.Plug.current_user(conn)
    case Borrowables.create_borrow_request(user, borrower_organization_id, borrowable_item) do
      {:ok, borrow_request} ->
        conn
        |> put_flash(:info, "Borrow request created successfully.")
        |> redirect(to: Routes.organization_borrowable_item_borrow_request_path(conn, :show, organization_id, item_id, borrow_request))

      {:error, %Ecto.Changeset{} = changeset} ->
        conn
        |> put_flash(:error, "Borrow request failed")
        |> redirect(to: Routes.organization_borrowable_item_path(conn, :show, organization_id, item_id))
    end
  end

  def show(conn, %{"organization_id" => organization_id, "borrowable_item_id" => item_id, "id" => id}) do
    organization = Borrowables.get_organization!(organization_id)
    borrowable_item = Borrowables.get_borrowable_item!(item_id)
    borrow_request = Borrowables.get_borrow_request!(id)
    user = Pow.Plug.current_user(conn)
    can_current_user_approve = Borrowables.is_user_organization_admin(user, organization)
    render(conn, "show.html", can_current_user_approve: can_current_user_approve, organization: organization, borrowable_item: borrowable_item, borrow_request: borrow_request)
  end

  def approve(conn, %{"organization_id" => organization_id, "borrowable_item_id" => item_id, "borrow_request_id" => id}) do
    user = Pow.Plug.current_user(conn)
    case Borrowables.approve_borrow_request!(user, id) do
      {:ok, borrow_request} ->
        conn
        |> put_flash(:info, "Request Approved")
        |> redirect(to: Routes.organization_borrowable_item_borrow_request_path(conn, :index, organization_id, item_id))
      {:error, %Ecto.Changeset{} = changeset} ->
        conn
        |> put_flash(:error, "Request Approval failed")
        |> redirect(to: Routes.organization_borrowable_item_borrow_request_path(conn, :index, organization_id, item_id))
    end
  end

  def deny(conn, %{"organization_id" => organization_id, "borrowable_item_id" => item_id, "borrow_request_id" => id}) do
    user = Pow.Plug.current_user(conn)
    case Borrowables.deny_borrow_request!(user, id) do
      {:ok, borrow_request} ->
        conn
        |> put_flash(:info, "Request Denied")
        |> redirect(to: Routes.organization_borrowable_item_borrow_request_path(conn, :index, organization_id, item_id))
      {:error, %Ecto.Changeset{} = changeset} ->
        conn
        |> put_flash(:error, "Request Denial failed")
        |> redirect(to: Routes.organization_borrowable_item_borrow_request_path(conn, :index, organization_id, item_id))
    end
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
end
