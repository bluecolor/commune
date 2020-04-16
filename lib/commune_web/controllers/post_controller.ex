defmodule CommuneWeb.PostController do
  use CommuneWeb, :controller

  alias Commune.Content
  alias Commune.Content.{Post, Comment}

  def new(conn, _params) do
    changeset = Content.change_post(%Post{comments: [
      %Comment{}
    ]})
    render(conn, "new.html", changeset: changeset)
  end

  def create(conn,  %{"post" => post_params}) do
    IO.inspect(post_params)
    case Content.create_post(post_params) do
      {:ok, _} ->
        conn
        |> redirect(to: Routes.post_path(conn, :new))
      {:error, %Ecto.Changeset{} = changeset} ->
        IO.inspect(changeset)
        |> redirect(to: Routes.post_path(conn, :new))
    end
  end
end
