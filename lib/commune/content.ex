defmodule Commune.Content do

  import Ecto.Query, warn: false
  alias Commune.Repo

  alias Commune.Content.{Post, Comment}


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

  def change_comment(%Comment{} = comment) do
    Comment.changeset(comment, %{})
  end

  def list_posts_with_comment_count do
    query = from p in Post,
      join: c in Comment,
      on: p.id == c.post_id,
      group_by: p.title,
      select: {p.title, count(c.id)}

    Repo.all(query)
  end

end
