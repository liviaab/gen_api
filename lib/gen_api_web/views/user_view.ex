defmodule GenApiWeb.UserView do
  use GenApiWeb, :view
  alias GenApiWeb.UserView

  def render("index.json", %{users: users, timestamp: timestamp}) do
    %{
      data: render_many(users, UserView, "user.json"),
      timestamp: timestamp
    }
  end

  def render("show.json", %{user: user}) do
    %{data: render_one(user, UserView, "user.json")}
  end

  def render("user.json", %{user: user}) do
    %{id: user.id, points: user.points}
  end
end
