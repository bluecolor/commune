defmodule CommuneWeb.PostView do
  use CommuneWeb, :view
  import Scrivener.HTML

  def is_comment_liked(comment) do
    "comment-liked"
  end

end
