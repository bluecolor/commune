defmodule Commune.Repo.Migrations.CreatePosts do
  use Ecto.Migration

  def change do
    create table(:posts) do
      add :body, :string
      add :topic, references(:posts, on_delete: :delete_all)
      add :owner, references(:users, on_delete: :nothing)

      timestamps()
    end

    create index(:posts, [:topic])
    create index(:posts, [:owner])
  end
end
