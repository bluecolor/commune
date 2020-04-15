defmodule CommuneWeb.TopicController do
  use CommuneWeb, :controller

  alias Commune.Content
  alias Commune.Content.{Topic, Post}

  def new(conn, _params) do
    changeset = Content.change_topic(%Topic{posts: [
      %Post{}
    ]})
    render(conn, "new.html", changeset: changeset)
  end

  def create(conn,  %{"topic" => topic_params}) do
    IO.inspect(topic_params)
    conn
    |> redirect(to: Routes.topic_path(conn, :new))
  end
end
