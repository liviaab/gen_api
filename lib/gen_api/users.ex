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

  @spec update_all_users_points() :: {integer(), nil}
  def update_all_users_points() do
    update(User, set: [points: fragment("floor(random()*100)"), updated_at: fragment("now()")])
    |> Repo.update_all([])
  end
end
