defmodule Uplog.Borrowables.BorrowRequest do
  use Ecto.Schema
  import Ecto.Changeset

  schema "borrow_requests" do
    belongs_to :approved_by, Uplog.Users.User
    field :approved_at, :naive_datetime

    belongs_to :denied_by, Uplog.Users.User
    field :denied_at, :naive_datetime
    field :denied_because, :string

    field :claimed_at, :naive_datetime

    belongs_to :received_back_by, Uplog.Users.User
    field :received_back_at, :naive_datetime

    belongs_to :item, Uplog.Borrowables.BorrowableItem
    belongs_to :borrower_user, Uplog.Users.User
    belongs_to :borrower_organization, Uplog.Borrowables.Organization

    timestamps()
  end

  @doc false
  def changeset(borrow_request, attrs) do
    borrow_request
    |> cast(attrs, [:borrower_organization_id])
    |> validate_required([])
  end
end
