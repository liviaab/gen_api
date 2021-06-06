defmodule GenApi.Users do
  @moduledoc """
  The Users context.
  """

  import Ecto.Query, warn: false
  alias GenApi.Repo

  alias GenApi.Users.User

  @spec list_users(map()) :: [%User{}]
  def list_users(%{limit: limit, min_points: min_points}) do
    query =
      from u in User,
        limit: ^limit,
        where: u.points > ^min_points

    Repo.all(query)
  end

  @spec get_user(integer()) :: {:ok, %User{}} | {:error, :not_found}
  def get_user(id) do
    case Repo.get(User, id) do
      nil -> {:error, :not_found}
      user -> {:ok, user}
    end
  end

  @spec create_user(map()) :: {:ok, %User{}} | {:error, %Ecto.Changeset{}}
  def create_user(attrs \\ %{}) do
    %User{}
    |> User.changeset(attrs)
    |> Repo.insert()
  end

  @spec update_user(%User{}, map()) :: {:ok, %User{}} | {:error, %Ecto.Changeset{}}
  def update_user(%User{} = user, attrs) do
    user
    |> User.changeset(attrs)
    |> Repo.update()
  end

  @spec update_all_users_points() :: [%User{}]
  def update_all_users_points() do
    User
    |> Repo.all()
    |> Enum.map(fn user ->
      {:ok, user} = update_user(user, %{points: Enum.random(0..100)})

      user
    end)
  end

  @spec change_user(%User{}, map()) :: %Ecto.Changeset{}
  def change_user(%User{} = user, attrs \\ %{}) do
    User.changeset(user, attrs)
  end
end
