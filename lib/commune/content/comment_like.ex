defmodule Commune.Content.CommentLike do
  use Ecto.Schema

  @primary_key false
  schema "comment_likes" do
    belongs_to :user, Commune.Accounts.User
    belongs_to :comment, Commune.Content.Comment

    timestamps()
  end
end
