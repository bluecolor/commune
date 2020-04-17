defmodule CommuneWeb.LayoutView do
  use CommuneWeb, :view

  alias Commune.Content

  def trends do
    "Trends for you"
  end

  def list_posts_with_comment_count do
    Content.list_posts_with_comment_count()
  end

  def comment_count(c) do
    if c > 1, do: "#{c} Commnets", else: "#{c} Commnet"
  end

end
