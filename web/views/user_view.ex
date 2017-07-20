defmodule Whitepages2.UserView do
  use Whitepages2.Web, :view

  def render("index.json", %{users: users}) do
    %{data: render_many(users, Whitepages2.UserView, "user.json")}
  end

  def render("show.json", %{user: user}) do
    %{data: render_one(user, Whitepages2.UserView, "user.json")}
  end

  def render("user.json", %{user: user}) do
    %{id: user.id,
      canvas_user_id: user.canvas_user_id,
      sis_id: user.sis_id,
      data: user.data
    }
  end
end
