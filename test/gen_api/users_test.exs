defmodule GenApi.UsersTest do
  use GenApi.DataCase

  alias GenApi.Users

  describe "users" do
    alias GenApi.Users.User

    @valid_attrs %{points: 42}
    @update_attrs %{points: 43}
    @invalid_attrs %{points: nil}

    def user_fixture(attrs \\ %{}) do
      {:ok, user} =
        attrs
        |> Enum.into(@valid_attrs)
        |> Users.create_user()

      user
    end

    test "list_users/1 returns a certain amount of users" do
      Enum.map(1..5, fn _ -> user_fixture() end)

      result = Users.list_users(%{limit: 2, min_points: 0})
      assert is_list(result)
      assert length(result) == 2
    end

    test "list_users/1 considers the filters" do
      Enum.map(1..5, fn _ -> user_fixture() end)

      result = Users.list_users(%{limit: 2, min_points: 50})
      assert is_list(result)
      assert result == []
    end

    test "get_user/1 returns the user with given id" do
      user = user_fixture()
      assert {:ok, result} = Users.get_user(user.id)
      assert result == user
    end

    test "create_user/1 with valid data creates a user" do
      assert {:ok, %User{} = user} = Users.create_user(@valid_attrs)
      assert user.points == 42
    end

    test "create_user/1 with invalid data returns error changeset" do
      assert {:error, %Ecto.Changeset{}} = Users.create_user(@invalid_attrs)
    end

    test "create_user/1 with points out of the 0-100 range returns error changeset" do
      assert {:error, %Ecto.Changeset{}} = Users.create_user(%{points: 101})
    end

    test "update_user/2 with valid data updates the user" do
      user = user_fixture()
      assert {:ok, %User{} = user} = Users.update_user(user, @update_attrs)
      assert user.points == 43
    end

    test "update_user/2 with invalid data returns error changeset" do
      user = user_fixture()
      assert {:error, %Ecto.Changeset{}} = Users.update_user(user, @invalid_attrs)
      assert {:ok, user} == Users.get_user(user.id)
    end

    test "update_all_users_points/0 when there are no users returns 0" do
      assert [] = Users.update_all_users_points()
    end

    test "update_all_users_points/ updates all users points" do
      Enum.map(1..5, fn _ -> user_fixture() end)

      assert users = Users.update_all_users_points()
      assert is_list(users)
      assert length(users) == 5
    end

    test "change_user/1 returns a user changeset" do
      user = user_fixture()
      assert %Ecto.Changeset{} = Users.change_user(user)
    end
  end
end
