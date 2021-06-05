defmodule GenApiWeb.UserController do
  use GenApiWeb, :controller

  alias GenApi.Users

  action_fallback GenApiWeb.FallbackController

  def index(conn, _params) do
    users = Users.list_users()
    render(conn, "index.json", users: users)
  end
end
