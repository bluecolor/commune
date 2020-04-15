defmodule CommuneWeb.SessionController do
  use CommuneWeb, :controller
  alias Commune.Accounts

  def create(conn, %{"session" => auth_params}) do
    user = Accounts.get_by_email_or_username(auth_params["username"])

    case Bcrypt.check_pass(user, auth_params["password"]) do
      {:ok, user} ->
        conn
        |> put_session(:current_user_id, user.id)
        |> redirect(to: Routes.page_path(conn, :index))
      {:error, _} ->
        conn
        |> put_flash(:error, "There was a problem with your username/password")
        |> redirect(to: Routes.page_path(conn, :index))
    end
  end

  def delete(conn, _params) do
    conn
    |> delete_session(:current_user_id)
    |> delete_session(:current_usr)
    |> redirect(to: Routes.page_path(conn, :index))
  end

end
