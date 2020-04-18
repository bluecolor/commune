defmodule CommuneWeb.CommentController do
  use CommuneWeb, :controller

  alias Commune.Content
  alias Commune.Content.{Post, Comment}

  def create(conn,  %{"comment" => comment_params, "draft" => draft, "post_id" => post_id}) do
    IO.inspect(comment_params)
    IO.inspect(draft)
    IO.inspect(post_id)
    conn
    |> redirect(to: Routes.post_path(conn, :new))
  end

end
