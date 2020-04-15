defmodule Commune.Content.Topic do
  use Ecto.Schema
  import Ecto.Changeset

  schema "topics" do
    field :title, :string
    belongs_to :owner, Commune.Accounts.User, references: :id
    has_many :posts, Commune.Content.Post

    timestamps()
  end

  @doc false
  def changeset(topic, attrs) do
    topic
    |> cast(attrs, [:title])
    |> validate_required([:title])
    |> cast_assoc(:posts, required: true)
    |> cast_assoc(:owner, required: false)
  end
end
