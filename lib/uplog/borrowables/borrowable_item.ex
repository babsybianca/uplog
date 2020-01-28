defmodule Uplog.Borrowables.BorrowableItem do
  use Ecto.Schema
  import Ecto.Changeset

  schema "borrowable_items" do
    field :description, :string
    field :name, :string
    field :visible, :boolean, default: true
    has_many :borrow_requests, Uplog.Borrowables.BorrowRequest
    belongs_to :organization, Uplog.Borrowables.Organization

    timestamps()
  end

  @doc false
  def changeset(borrowable_item, attrs) do
    borrowable_item
    |> cast(attrs, [:name, :description, :visible])
    |> validate_required([:name, :description])
  end
end
