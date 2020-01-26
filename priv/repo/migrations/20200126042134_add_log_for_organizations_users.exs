defmodule Uplog.Repo.Migrations.AddLogForOrganizationsUsers do
  use Ecto.Migration

  def change do
    alter table(:organizations_users) do
      add :added_by_user_id, references(:users, on_delete: :nothing)
    end
  end
end
