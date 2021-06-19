defmodule GenApiWeb.UserController do
  use GenApiWeb, :controller

  action_fallback GenApiWeb.FallbackController

  def index(conn, _params) do
    {users, timestamp} = user_server().get_users()
    render(conn, "index.json", %{users: users, timestamp: timestamp})
  end

  defp user_server(), do: Application.get_env(:gen_api, :user_server)
end
