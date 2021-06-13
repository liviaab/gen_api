defmodule GenApi.UsersTest do
  use GenApi.DataCase

  alias GenApi.Users

  describe "users" do
    alias GenApi.Users.User

    @valid_attrs %{points: 42}
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

    test "update_all_users_points/0 when there are no users returns 0" do
      assert {0, nil} = Users.update_all_users_points()
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
  end
end
