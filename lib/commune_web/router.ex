defmodule CommuneWeb.Router do
  use CommuneWeb, :router

  pipeline :browser do
    plug :accepts, ["html"]
    plug :fetch_session
    plug :fetch_flash
    plug :protect_from_forgery
    plug :put_secure_browser_headers
    plug CommuneWeb.Plugs.SetCurrentUser
  end

  pipeline :api do
    plug :accepts, ["json"]
    plug CommuneWeb.Plugs.SetCurrentUser
  end

  pipeline :login do
    plug :put_layout, {CommuneWeb.LayoutView, "login.html"}
  end

  if Mix.env == :dev do
    forward "/sent_emails", Bamboo.SentEmailViewerPlug
  end

  scope "/api", CommuneWeb, as: :api do
    pipe_through :api
  end

  scope "/", CommuneWeb do
    pipe_through :browser

    get "/", PageController, :index
    get "/activate", UserController, :activate_user

    resources "/posts", PostController, only: [:new, :create, :show] do
      resources "/comments", CommentController, only: [:create, :delete, :update] do
        put "/like", CommentController, :like
      end
    end
  end

  scope "/", CommuneWeb do
    pipe_through [:browser, :login]
    get "/login", UserController, :login
    get "/signup", UserController, :signup
    post "/signup", UserController, :create
    get  "/verify", UserController, :show_verify
    post "/verify", UserController, :verify

    post "/signin", SessionController, :create
    get  "/signout", SessionController, :delete
    delete "/signout", SessionController, :delete
  end

  # Other scopes may use custom stacks.
  # scope "/api", CommuneWeb do
  #   pipe_through :api
  # end
end
