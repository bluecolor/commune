defmodule Commune.Content.Post do
  use Ecto.Schema
  import Ecto.Changeset

  schema "posts" do
    field :title, :string
    belongs_to :owner, Commune.Accounts.User, references: :id
    has_many :comments, Commune.Content.Comment

    timestamps()
  end

  @doc false
  def changeset(post, attrs) do
    post
    |> cast(attrs, [:title])
    |> validate_required([:title])
    |> cast_assoc(:comments, required: true)
    |> cast_assoc(:owner, required: false)
  end
end
