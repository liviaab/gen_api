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
    GenApi.GenServers.UserServerMock.init()
    {:ok, conn: put_req_header(conn, "accept", "application/json")}
  end

  describe "index" do
    test "lists all users - an empty list if there's no users", %{conn: conn} do
      conn = get(conn, Routes.user_path(conn, :index))
      response = json_response(conn, 200)

      assert response == %{"data" => [], "timestamp" => nil}
    end

    test "lists all users - a list with one record list if there's one user", %{conn: conn} do
      user = fixture(:user)
      conn = get(conn, Routes.user_path(conn, :index))
      response = json_response(conn, 200)

      assert response["data"] == [%{"id" => user.id, "points" => user.points}]
      assert is_nil(response["timestamp"])
    end

    test "lists all users - at most two users", %{conn: conn} do
      fixture(:user)
      fixture(:user)
      fixture(:user)
      conn = get(conn, Routes.user_path(conn, :index))
      response = json_response(conn, 200)

      assert length(response["data"]) == 2
      assert is_nil(response["timestamp"])
    end

    test "shows previous timestamp in the second call", %{conn: conn} do
      # First call returns nil timestamp - covered in previous tests
      conn = get(conn, Routes.user_path(conn, :index))

      # Second call should return a string with the timestamp os the previous call
      conn = get(conn, Routes.user_path(conn, :index))
      response = json_response(conn, 200)

      assert is_list(response["data"])
      assert is_binary(response["timestamp"])
    end

  end
end
