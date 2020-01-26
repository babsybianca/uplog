defmodule Uplog.Repo.Migrations.CreateOrganizations do
  use Ecto.Migration

  def change do
    create table(:organizations) do
      add :name, :string
      add :description, :text
      add :active, :boolean, default: true, null: false
      add :visible, :boolean, default: true, null: false

      timestamps()
    end

  end
end
