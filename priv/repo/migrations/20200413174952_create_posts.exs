defmodule Commune.Repo.Migrations.CreatePosts do
  use Ecto.Migration

  def change do
    create table(:posts) do
      add :title, :string
      add :owner_id, references(:users, on_delete: :nothing), null: true

      timestamps()
    end
  end
end
