defmodule CommuneWeb.CommentController do
  use CommuneWeb, :controller

  alias Commune.Content
  alias Commune.Content.{Post, Comment}

  def create(conn,  %{"comment" => comment_params, "draft" => is_draft, "post_id" => post_id}) do

    IO.inspect(conn.assigns)

    case Content.create_comment(post_id, comment_params) do
      {:ok, _} ->
        conn
        |> redirect(to: Routes.post_path(conn, :show, post_id))
      {:error, %Ecto.Changeset{} = changeset} ->
        IO.inspect(changeset)
        conn
        |> redirect(to: Routes.post_path(conn, :show, post_id))
    end

  end

  def like(conn, %{"post_id"=> post_id,  "comment_id" => comment_id}) do
    IO.inspect(conn.assigns)
    IO.inspect(post_id)
    IO.inspect(comment_id)
    json conn, :ok
  end

  def dislike(conn, %{"post_id"=> post_id,  "comment_id" => comment_id}) do
    IO.inspect(conn)
    IO.inspect(post_id)
    IO.inspect(comment_id)
    json conn, :ok
  end



end
