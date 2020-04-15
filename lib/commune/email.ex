defmodule Commune.Email do
  use Bamboo.Phoenix, view: CommuneWeb.EmailView

  # import Bamboo.Email

  def send_code(user) do
    new_email(
      from: "commune.io",
      to: user.email,
      subject: "Activation code",
      text_body: "Your activation code is #{user.code}",
      html_body: "<p>Your activation code is <b>#{user.code}</b><p>"
    )
  end

  def send_activation(conn, user) do
    new_email
    |> from("no-reply@commune.io")
    |> to(user.email)
    |> put_html_layout({CommuneWeb.LayoutView, "email.html"})
    |> subject("Activation")
    |> assign(:user, user)
    |> assign(:conn, conn)
    |> render("user_activation.html")
  end

end
