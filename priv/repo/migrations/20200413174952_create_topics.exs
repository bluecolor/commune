defmodule Commune.Repo.Migrations.CreateTopics do
  use Ecto.Migration

  def change do
    create table(:topics) do
      add :title, :string
      add :owner_id, references(:users, on_delete: :nothing), null: true

      timestamps()
    end

    create index(:topics, [:owner_id])
  end
end
