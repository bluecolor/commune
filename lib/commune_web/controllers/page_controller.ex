defmodule CommuneWeb.PageController do
  use CommuneWeb, :controller

  def index(conn, _params) do
    render(conn, "index.html")
  end
end
