defmodule Uplog.Repo.Migrations.CreateBorrowRequests do
  use Ecto.Migration

  def change do
    create table(:borrow_requests) do
      add :approved_at, :naive_datetime
      add :claimed_at, :naive_datetime
      add :received_back_at, :naive_datetime
      add :borrower_organization_id, references(:organizations, on_delete: :nothing)
      add :borrower_user_id, references(:users, on_delete: :nothing)
      add :item, references(:borrowable_items, on_delete: :nothing)
      add :approved_by, references(:users, on_delete: :nothing)
      add :received_back_by, references(:users, on_delete: :nothing)

      timestamps()
    end

    create index(:borrow_requests, [:borrower_organization_id])
    create index(:borrow_requests, [:borrower_user_id])
    create index(:borrow_requests, [:item])
    create index(:borrow_requests, [:approved_by])
    create index(:borrow_requests, [:received_back_by])
  end
end
