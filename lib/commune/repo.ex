defmodule Commune.Repo do
  use Ecto.Repo,
    otp_app: :commune,
    adapter: Ecto.Adapters.Postgres
end
