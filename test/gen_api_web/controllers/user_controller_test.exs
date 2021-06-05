defmodule GenApiWeb.UserControllerTest do
  use GenApiWeb.ConnCase

  alias GenApi.Users

  @create_attrs %{
    points: 42
  }

  def fixture(:user) do
    {:ok, user} = Users.create_user(@create_attrs)
    user
  end

  setup %{conn: conn} do
    {:ok, conn: put_req_header(conn, "accept", "application/json")}
  end

  describe "index" do
    test "lists all users", %{conn: conn} do
      conn = get(conn, Routes.user_path(conn, :index))
      assert json_response(conn, 200)["data"] == []
    end

    test "lists a maximum of two users", %{conn: conn} do
      Enum.map(1..5, fn _ -> fixture(:user) end)

      conn = get(conn, Routes.user_path(conn, :index))
      result = json_response(conn, 200)["data"]

      assert is_list(result)
      assert length(result) == 2
    end
  end
end
