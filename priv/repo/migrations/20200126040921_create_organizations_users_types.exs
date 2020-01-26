defmodule Uplog.Repo.Migrations.CreateOrganizationsUsersTypes do
  use Ecto.Migration

  def change do
    create table(:organizations_users_types) do
      add :name, :string

      timestamps()
    end

  end
end
