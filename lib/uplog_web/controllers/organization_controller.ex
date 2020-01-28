defmodule UplogWeb.OrganizationController do
  use UplogWeb, :controller

  alias Uplog.Borrowables
  alias Uplog.Borrowables.Organization

  def index(conn, _params) do
    organizations = Borrowables.list_organizations()
    render(conn, "index.html", organizations: organizations)
  end

  def new(conn, _params) do
    changeset = Borrowables.change_organization(%Organization{})
    render(conn, "new.html", changeset: changeset)
  end

  def create(conn, %{"organization" => organization_params}) do
    case Borrowables.create_organization(organization_params) do
      {:ok, organization} ->
        conn
        |> put_flash(:info, "Organization created successfully.")
        |> redirect(to: Routes.organization_path(conn, :show, organization))

      {:error, %Ecto.Changeset{} = changeset} ->
        render(conn, "new.html", changeset: changeset)
    end
  end

  def show(conn, %{"id" => id}) do
    organization = Borrowables.get_organization!(id)
    users = Borrowables.get_organization_users(organization)
    users_not_in_organization = Borrowables.get_users_not_in_organization(organization)
    user = Pow.Plug.current_user(conn)
    is_current_user_org_admin = Borrowables.is_user_organization_admin(user, organization)
    render(conn, "show.html", organization: organization, users: users, users_not_in_organization: users_not_in_organization, is_current_user_org_admin: is_current_user_org_admin)
  end

  def add_admin(conn, %{"organization_id" => id, "user_id" => user_id}) do
    organization = Borrowables.get_organization!(id)
    user = Borrowables.get_user(user_id)
    case Borrowables.add_organization_admin(organization, user) do
      {:ok, organization} ->
        conn
        |> put_flash(:info, "Admin added successfully")
        |> redirect(to: Routes.organization_path(conn, :show, id))
      {:error, %Ecto.Changeset{} = changeset} ->
        conn
        |> put_flash(:info, "Admin could not be added")
        |> redirect(to: Routes.organization_path(conn, :show, id))
    end
  end

  def edit(conn, %{"id" => id}) do
    organization = Borrowables.get_organization!(id)
    changeset = Borrowables.change_organization(organization)
    render(conn, "edit.html", organization: organization, changeset: changeset)
  end

  def update(conn, %{"id" => id, "organization" => organization_params}) do
    organization = Borrowables.get_organization!(id)

    case Borrowables.update_organization(organization, organization_params) do
      {:ok, organization} ->
        conn
        |> put_flash(:info, "Organization updated successfully.")
        |> redirect(to: Routes.organization_path(conn, :show, organization))

      {:error, %Ecto.Changeset{} = changeset} ->
        render(conn, "edit.html", organization: organization, changeset: changeset)
    end
  end

  def delete(conn, %{"id" => id}) do
    organization = Borrowables.get_organization!(id)
    {:ok, _organization} = Borrowables.delete_organization(organization)

    conn
    |> put_flash(:info, "Organization deleted successfully.")
    |> redirect(to: Routes.organization_path(conn, :index))
  end
end
