defmodule CommuneWeb.PostView do
  use CommuneWeb, :view
  import Scrivener.HTML

  def is_comment_liked(is_liked) do
    IO.inspect(is_liked)
    if is_liked, do: "comment-liked", else: ""
  end

end
