defmodule Uplog.Users.User do
  use Ecto.Schema
  use Pow.Ecto.Schema

  schema "users" do
    pow_user_fields()
    field :super_user, :boolean, default: false

    timestamps()
  end
end
