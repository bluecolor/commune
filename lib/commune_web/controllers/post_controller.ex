defmodule CommuneWeb.PostController do
  use CommuneWeb, :controller

  alias Commune.Content
  alias Commune.Content.Post

  def new(conn, _params) do
    changeset = Content.change_post(%Post{})
    render(conn, "new.html", changeset: changeset)
  end

  def create(conn, params) do
  end
end
