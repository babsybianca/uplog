defmodule Uplog.Repo.Migrations.CreateOrganizationsUsers do
  use Ecto.Migration

  def change do
    create table(:organizations_users) do
      add :organization_id, references(:organizations, on_delete: :nothing)
      add :user_id, references(:users, on_delete: :nothing)
      add :type, references(:organizations_users_types, on_delete: :nothing)

      timestamps()
    end

    create index(:organizations_users, [:organization_id])
    create index(:organizations_users, [:user_id])
    create index(:organizations_users, [:type])
  end
end
