defmodule Uplog.Borrowables.BorrowRequest do
  use Ecto.Schema
  import Ecto.Changeset

  schema "borrow_requests" do
    field :approved_at, :naive_datetime
    field :claimed_at, :naive_datetime
    field :received_back_at, :naive_datetime
    field :borrower_organization_id, :id
    field :borrower_user_id, :id
    field :item, :id
    field :approved_by, :id
    field :received_back_by, :id

    timestamps()
  end

  @doc false
  def changeset(borrow_request, attrs) do
    borrow_request
    |> cast(attrs, [:approved_at, :claimed_at, :received_back_at])
    |> validate_required([:approved_at, :claimed_at, :received_back_at])
  end
end
