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
    case Content.create_post(post_params) do
      {:ok, _} ->
        conn
        |> redirect(to: Routes.post_path(conn, :new))
      {:error, %Ecto.Changeset{} = changeset} ->
        IO.inspect(changeset)
        |> redirect(to: Routes.post_path(conn, :new))
    end
  end

  def show(conn, params) do
    post = Content.get_post!(params["id"])
    page = Content.get_commnets_page(params)

    IO.inspect(page)
    conn
    |> render("show.html", comments: page.entries, post: post, page: page)
  end


end
