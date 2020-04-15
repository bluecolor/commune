defmodule CommuneWeb.UserController do
  use CommuneWeb, :controller

  alias Commune.Accounts
  alias Commune.Accounts.User
  alias Commune.{Mailer, Email}
  alias CommuneWeb.PageView

  def login(conn, _params) do
    render(conn, "login.html")
  end

  def signup(conn, _params) do
    changeset = Accounts.change_user(%User{})
    render(conn, "signup.html", changeset: changeset)
  end

  def index(conn, _params) do
    users = Accounts.list_users()
    render(conn, "index.html", users: users)
  end

  def new(conn, _params) do
    changeset = Accounts.change_user(%User{})
    render(conn, "new.html", changeset: changeset)
  end

  defp send_activation(conn, user) do
    Email.send_activation(conn, user) |> Mailer.deliver_later()
  end

  def show_verify(conn, params) do
    conn
    |> render("verify.html", id: params["id"])
  end

  def activate_user(conn, params) do
    case Accounts.activate_user(URI.decode(params["u"])) do
      {:ok, user} ->
        conn
        |> put_flash(:info, "Your account is activated")
        |> put_session(:current_user_id, user.id)
        |> assign(:current_user, user)
        |> assign(:user_signed_in?, true)
        |> redirect(to: Routes.page_path(conn, :index))

      {:error, _} ->
        conn
        |> put_flash(:info, "Failed to validate account")
        |> redirect(to: Routes.page_path(conn, :index))
    end
  end

  def create(conn, %{"user" => user_params}) do
    case Accounts.create_user(user_params) do
      {:ok, user} ->
        send_activation(conn, user)
        conn
        # |> put_flash(:info, "User created successfully.")
        # |> render("verify.html", user: user)
        |> render("check-email.html")

      {:error, %Ecto.Changeset{} = changeset} ->
        IO.inspect(changeset)
        conn
        |> put_flash(:info, "Wrong email or password")
        |> render("signup.html", changeset: changeset)
    end
  end

  def verfiy_code(_, %{"params" => params}) do
    IO.inspect(params)
  end

  def show(conn, %{"id" => id}) do
    user = Accounts.get_user!(id)
    render(conn, "show.html", user: user)
  end

  def edit(conn, %{"id" => id}) do
    user = Accounts.get_user!(id)
    changeset = Accounts.change_user(user)
    render(conn, "edit.html", user: user, changeset: changeset)
  end

  @spec update(Plug.Conn.t(), map) :: Plug.Conn.t()
  def update(conn, %{"id" => id, "user" => user_params}) do
    user = Accounts.get_user!(id)

    case Accounts.update_user(user, user_params) do
      {:ok, user} ->
        conn
        |> put_flash(:info, "User updated successfully.")
        |> redirect(to: Routes.user_path(conn, :show, user))

      {:error, %Ecto.Changeset{} = changeset} ->
        render(conn, "edit.html", user: user, changeset: changeset)
    end
  end

  def delete(conn, %{"id" => id}) do
    user = Accounts.get_user!(id)
    {:ok, _user} = Accounts.delete_user(user)

    conn
    |> put_flash(:info, "User deleted successfully.")
    |> redirect(to: Routes.user_path(conn, :index))
  end

end

