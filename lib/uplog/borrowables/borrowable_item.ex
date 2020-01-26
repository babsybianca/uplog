defmodule Uplog.Borrowables.BorrowableItem do
  use Ecto.Schema
  import Ecto.Changeset

  schema "borrowable_items" do
    field :description, :string
    field :name, :string
    field :visible, :boolean, default: true
    field :organization_id, :id

    timestamps()
  end

  @doc false
  def changeset(borrowable_item, attrs) do
    borrowable_item
    |> cast(attrs, [:name, :description, :visible])
    |> validate_required([:name, :description, :visible])
  end
end
