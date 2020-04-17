defmodule Commune.Repo do
  use Ecto.Repo,
    otp_app: :commune,
    adapter: Ecto.Adapters.Postgres
  use Scrivener, page_size: 10
end
