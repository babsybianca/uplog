defmodule Uplog.Borrowables.OrganizationsUsers do
  use Ecto.Schema
  import Ecto.Changeset

  schema "organizations_users" do
    field :added_by_user_id, :id
    field :type, :id
    belongs_to :user, Uplog.Users.User
    belongs_to :organization, Uplog.Borrowables.Organization

    timestamps()
  end

  @doc false
  def changeset(organizations_users, attrs) do
    organizations_users
    |> cast(attrs, [])
    |> validate_required([])
  end
end
