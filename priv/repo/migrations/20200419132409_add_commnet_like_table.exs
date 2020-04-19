defmodule Commune.Repo.Migrations.AddCommnetLikeTable do
  use Ecto.Migration

  def change do
    create table(:comment_like, primary_key: false) do
      add(:comment_id, references(:comments, on_delete: :delete_all), primary_key: true)
      add(:user_id, references(:users, on_delete: :delete_all), primary_key: true)
      timestamps()
    end

    create(index(:comment_like, [:comment_id]))
    create(index(:comment_like, [:user_id]))

    create(
      unique_index(:comment_like, [:comment_id, :user_id], name: :comment_id_user_id_unique_index)
    )
  end
end
