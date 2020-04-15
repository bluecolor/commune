defmodule CommuneWeb.EmailView do
  use CommuneWeb, :view

  alias CommuneWeb.Endpoint

  def activation_url(user) do
    "#{Endpoint.url()}/activate?#{URI.encode_query(%{:u => user.email, :c => user.code})}"
  end

end
