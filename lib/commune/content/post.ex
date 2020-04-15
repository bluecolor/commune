defmodule Commune.Content.Post do
  use Ecto.Schema
  import Ecto.Changeset

  schema "posts" do
    field :body, :string
    belongs_to :topic, Commune.Content.Topic, references: :id
    belongs_to :owner, Commune.Accounts.User, references: :id

    timestamps()
  end

  @doc false
  def changeset(post, attrs) do
    post
    |> cast(attrs, [:body])
    |> validate_required([:body])
  end
end
