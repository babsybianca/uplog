defmodule UplogWeb.BorrowRequestController do
  use UplogWeb, :controller

  alias Uplog.Borrowables
  alias Uplog.Borrowables.BorrowRequest

  def index(conn, %{"organization_id" => organization_id, "borrowable_item_id" => item_id}) do
    organization = Borrowables.get_organization!(organization_id)
    borrowable_item = Borrowables.get_borrowable_item!(item_id)
    borrow_requests = Borrowables.list_borrow_requests()
    render(conn, "index.html", organization: organization, borrowable_item: borrowable_item, borrow_requests: borrow_requests)
  end

  def create(conn, %{"organization_id" => organization_id, "borrowable_item_id" => item_id}) do
    organization = Borrowables.get_organization!(organization_id)
    borrowable_item = Borrowables.get_borrowable_item!(item_id)
    user = Pow.Plug.current_user(conn)
    case Borrowables.create_borrow_request(user, 1, borrowable_item) do
      {:ok, borrow_request} ->
        conn
        |> put_flash(:info, "Borrow request created successfully.")
        |> redirect(to: Routes.organization_borrowable_item_borrow_request_path(conn, :show, organization_id, item_id, borrow_request))

      {:error, %Ecto.Changeset{} = changeset} ->
        conn
        |> put_flash(:error, "Borrow request failed")
        |> redirect(to: Routes.organization_borrowable_item_path(conn, :show, organization_id, item_id, [changeset: changeset]))
    end
  end

  def show(conn, %{"organization_id" => organization_id, "borrowable_item_id" => item_id, "id" => id}) do
    organization = Borrowables.get_organization!(organization_id)
    borrowable_item = Borrowables.get_borrowable_item!(item_id)
    borrow_request = Borrowables.get_borrow_request!(id)
    render(conn, "show.html", organization: organization, borrowable_item: borrowable_item, borrow_request: borrow_request)
  end

  def approve(conn, %{"organization_id" => organization_id, "borrowable_item_id" => item_id, "borrow_request_id" => id}) do
    user = Pow.Plug.current_user(conn)
    case Borrowables.approve_borrow_request!(user, id) do
      {:ok, borrow_request} ->
        conn
        |> put_flash(:info, "Request Approved")
        |> redirect(to: Routes.organization_borrowable_item_borrow_request_path(conn, :show, organization_id, item_id, id))
      {:error, %Ecto.Changeset{} = changeset} ->
        conn
        |> put_flash(:error, "Request Approval failed")
        |> redirect(to: Routes.organization_borrowable_item_borrow_request_path(conn, :show, organization_id, item_id, id))
    end
  end

  def deny(conn, %{"organization_id" => organization_id, "borrowable_item_id" => item_id, "borrow_request_id" => id}) do
    user = Pow.Plug.current_user(conn)
    case Borrowables.deny_borrow_request!(user, id) do
      {:ok, borrow_request} ->
        conn
        |> put_flash(:info, "Request Denied")
        |> redirect(to: Routes.organization_borrowable_item_borrow_request_path(conn, :show, organization_id, item_id, id))
      {:error, %Ecto.Changeset{} = changeset} ->
        conn
        |> put_flash(:error, "Request Denial failed")
        |> redirect(to: Routes.organization_borrowable_item_borrow_request_path(conn, :show, organization_id, item_id, id))
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
