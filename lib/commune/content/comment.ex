defmodule Commune.Content.Comment do
  use Ecto.Schema
  import Ecto.Changeset

  alias Commune.Accounts.User

  schema "comments" do
    field :body, :string
    belongs_to :post, Commune.Content.Post, references: :id
    belongs_to :owner, Commune.Accounts.User, references: :id
    many_to_many :liked_by, User, join_through: Commune.Content.CommentLike, on_replace: :delete

    timestamps()
  end

  @doc false
  def changeset(comment, attrs \\ %{}) do
    comment
    |> cast(attrs, [:body])
    |> validate_required([:body])
  end
end
