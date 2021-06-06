defmodule GenApiWeb.UserController do
  use GenApiWeb, :controller

  alias GenApi.GenServers.UserServer

  action_fallback GenApiWeb.FallbackController

  def index(conn, _params) do
    {users, timestamp} = UserServer.get_users()
    render(conn, "index.json", %{users: users, timestamp: timestamp})
  end
end
