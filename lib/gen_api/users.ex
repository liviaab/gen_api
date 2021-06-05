defmodule GenApi.Users do
  @moduledoc """
  The Users context.
  """

  import Ecto.Query, warn: false
  alias GenApi.Repo

  alias GenApi.Users.User

  @spec list_users() :: [%User{}]
  def list_users() do
    Repo.all(User)
  end

  @spec list_users(map()) :: [%User{}]
  def list_users(%{limit: limit}) do
    query = from User, limit: ^limit
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

  @spec change_user(%User{}, map()) :: %Ecto.Changeset{}
  def change_user(%User{} = user, attrs \\ %{}) do
    User.changeset(user, attrs)
  end
end
