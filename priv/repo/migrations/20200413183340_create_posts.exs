defmodule Commune.Repo.Migrations.CreatePosts do
  use Ecto.Migration

  def change do
    create table(:posts) do
      add :body, :string
      add :topic_id, references(:topics, on_delete: :delete_all)
      add :owner_id, references(:users, on_delete: :nothing), null: true

      timestamps()
    end

    # create index(:posts, [:topic])
    # create index(:posts, [:owner_id])
  end
end
