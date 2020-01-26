defmodule Uplog.Repo.Migrations.AddDenyForBorrowRequests do
  use Ecto.Migration

  def change do
    alter table(:borrow_requests) do
      add :denied_by, references(:users, on_delete: :nothing)
      add :denied_at, :naive_datetime
      add :denied_because, :text
    end
  end
end
