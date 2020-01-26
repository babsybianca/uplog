defmodule Uplog.Repo.Migrations.CreateBorrowableItems do
  use Ecto.Migration

  def change do
    create table(:borrowable_items) do
      add :name, :string
      add :description, :text
      add :visible, :boolean, default: true, null: false
      add :organization_id, references(:organizations, on_delete: :nothing)

      timestamps()
    end

    create index(:borrowable_items, [:organization_id])
  end
end
