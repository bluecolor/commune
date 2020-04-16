defmodule Commune.Repo.Migrations.CreateComments do
  use Ecto.Migration

  def change do
    create table(:comments) do
      add :body, :string
      add :post_id, references(:posts, on_delete: :delete_all)
      add :owner_id, references(:users, on_delete: :nothing), null: true

      timestamps()
    end

  end
end
