defmodule Uplog.Accounts.OrganizationsUsersTypes do
  use Ecto.Schema
  import Ecto.Changeset

  schema "organizations_users_types" do
    field :name, :string

    timestamps()
  end

  @doc false
  def changeset(organizations_users_types, attrs) do
    organizations_users_types
    |> cast(attrs, [:name])
    |> validate_required([:name])
  end
end
