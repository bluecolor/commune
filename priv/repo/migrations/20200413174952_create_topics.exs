defmodule Commune.Repo.Migrations.CreateTopics do
  use Ecto.Migration

  def change do
    create table(:topics) do
      add :title, :string
      add :owner, references(:users, on_delete: :nothing)

      timestamps()
    end

    create index(:topics, [:owner])
  end
end
