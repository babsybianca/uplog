defmodule Uplog.Repo do
  use Ecto.Repo,
    otp_app: :uplog,
    adapter: Ecto.Adapters.Postgres
end
