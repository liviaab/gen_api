defmodule GenApi.GenServers.UserServerTest do
  use GenApi.DataCase, async: false

  alias GenApi.GenServers.UserServer

  describe "start_link/1" do
    test "inits genserver when application starts" do
      assert {:error, {:already_started, pid}} = UserServer.start_link(nil)
      assert is_pid(pid)
    end
  end

  describe "get_users/0" do
    setup do
      :ok = UserServer.stop()
      UserServer.start_link(nil)

      :ok
    end

    @tag :unreliable
    test "returns users and nil timestamp in the first call" do
      {users, timestamp} =  UserServer.get_users()
      assert is_list(users)
      assert is_nil(timestamp)
    end

    @tag :unreliable
    test "returns users and not nil timestamp in the second call" do
      UserServer.get_users()
      {users, timestamp} =  UserServer.get_users()
      assert is_list(users)
      assert not is_nil(timestamp)
    end
  end
end
