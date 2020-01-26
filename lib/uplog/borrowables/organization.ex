defmodule Uplog.Borrowables.Organization do
  use Ecto.Schema
  import Ecto.Changeset

  schema "organizations" do
    field :active, :boolean, default: true
    field :description, :string
    field :name, :string
    field :visible, :boolean, default: true

    timestamps()
  end

  @doc false
  def changeset(organization, attrs) do
    organization
    |> cast(attrs, [:name, :description, :active, :visible])
    |> validate_required([:name, :description, :active, :visible])
  end
end
