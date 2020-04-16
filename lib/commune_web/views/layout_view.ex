defmodule CommuneWeb.LayoutView do
  use CommuneWeb, :view

  alias Commune.Content

  def trends do
    "Trends for you"
  end

  def list_posts_with_comment_count do
    # posts = Content.list_posts()
    # IO.inspect(posts)
    # posts
    Content.list_posts_with_comment_count()
  end

end
