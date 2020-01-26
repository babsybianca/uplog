defmodule Uplog.Borrowables.Organization do
  use Ecto.Schema
  import Ecto.Changeset

  schema "organizations" do
    field :active, :boolean, default: true
    field :description, :string
    field :name, :string
    field :visible, :boolean, default: true
    has_many :borrowable_items, Uplog.Borrowables.BorrowableItem
    many_to_many :users, Uplog.Users.User, join_through: Uplog.Borrowables.OrganizationsUsers

    timestamps()
  end

  @doc false
  def changeset(organization, attrs) do
    organization
    |> cast(attrs, [:name, :description, :active, :visible])
    |> validate_required([:name, :description, :active, :visible])
  end
end
