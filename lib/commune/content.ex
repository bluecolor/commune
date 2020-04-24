defmodule Commune.Content do

  import Ecto.Query, warn: false
  alias Commune.Repo

  alias Commune.Content.{Post, Comment, CommentLike}
  alias Commune.Accounts.User

  ### Post ###

  def list_posts do
    Repo.all(Post)
  end

  def get_post!(id), do: Repo.get!(Post, id)

  def create_post(attrs \\ %{}) do
    %Post{}
    |> Post.changeset(attrs)
    |> Repo.insert()
  end

  def update_post(%Post{} = post, attrs) do
    post
    |> Post.changeset(attrs)
    |> Repo.update()
  end

  def delete_post(%Post{} = post) do
    Repo.delete(post)
  end

  def change_post(%Post{} = post) do
    Post.changeset(post, %{})
  end

  ### Comment ###

  def get_comment!(id), do: Repo.get!(Comment, id)

  def change_comment(%Comment{} = comment) do
    Comment.changeset(comment, %{})
  end

  def create_comment(post_id, is_draft, comment \\ %{}) do
    get_post!(post_id)
    |> Ecto.build_assoc(:comments, body: comment["body"], is_draft: is_draft)
    |> Repo.insert()
  end

  def delete_comment(%Comment{} = comment) do
    Repo.delete(comment)
  end

  def like_comment(current_user, comment_id) do
    current_user
    |> Repo.preload(:liked_comments)
    |> Ecto.Changeset.change
    |> Ecto.Changeset.put_assoc(:liked_comments, [get_comment!(comment_id)])
    |> Repo.update()
  end


  def list_posts_with_comment_count do
    query = from p in Post,
      join: c in Comment,
      on: p.id == c.post_id,
      group_by: [p.id, p.title],
      select: {p.id, p.title, count(c.id)}

    Repo.all(query)
  end

  def get_commnets_page(current_user_id, params) do
    query = from p in Post,
      join: c in assoc(p, :comments),
      left_join: cl in CommentLike,
      on: c.id == cl.comment_id,
      left_join: u in User,
      on: cl.user_id == u.id and u.id == ^current_user_id,
      where: p.id == ^params["id"] and c.is_draft == false,
      select: %{comment: c, is_liked: not is_nil(u.id)}

    Repo.paginate(query, params)
  end

end
