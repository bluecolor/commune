defmodule CommuneWeb.CommentController do
  use CommuneWeb, :controller

  alias Commune.Content
  # alias Commune.Content.{Post, Comment}


  def edit(conn, %{"comment_id" => comment_id, "post_id" => post_id}) do
    post = Content.get_post!(post_id)
    comment = Content.get_comment!(comment_id)
    conn
    |> render("edit.html", comment: comment, post: post)
  end

  def create(conn,  %{"comment" => comment_params, "draft" => is_draft, "post_id" => post_id}) do
    case Content.create_comment(post_id, is_draft=="true", comment_params) do
      {:ok, _} ->
        conn
        |> redirect(to: Routes.post_path(conn, :show, post_id))
      {:error, %Ecto.Changeset{} = changeset} ->
        IO.inspect(changeset)
        conn
        |> redirect(to: Routes.post_path(conn, :show, post_id))
    end
  end

  def delete(conn, %{"id" => id}) do
    comment = Content.get_comment!(id)
    case Content.delete_comment(comment) do
      {:ok, _} -> json conn, :ok
      {:error, _} -> json conn, :error
    end
  end

  def like(conn, %{"comment_id" => comment_id}) do
    IO.inspect(comment_id)
    case Content.like_comment(conn.assigns.current_user, comment_id) do
      {:ok, _} -> json conn, :ok
      {:error, _} -> json conn, :error
    end
  end

  def dislike(conn, %{"post_id"=> post_id,  "comment_id" => comment_id}) do
    IO.inspect(conn)
    IO.inspect(post_id)
    IO.inspect(comment_id)
    json conn, :ok
  end



end
