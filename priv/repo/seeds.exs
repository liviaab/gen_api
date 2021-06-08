# Script for populating the database. You can run it as:
#
#     mix run priv/repo/seeds.exs
#
# Inside the script, you can read and write to any of your
# repositories directly:
#
#     GenApi.Repo.insert!(%GenApi.SomeSchema{})
#
# We recommend using the bang functions (`insert!`, `update!`
# and so on) as they will fail if something goes wrong.

alias GenApi.{Repo, Users.User}

users =
  Enum.map(1..1_000_000, fn _ ->
    now = NaiveDateTime.utc_now() |> NaiveDateTime.truncate(:second)
    %{points: 0, inserted_at: now, updated_at: now}
  end)

list_of_batches = Enum.chunk_every(users, 21_500)

Enum.each(list_of_batches, fn batch ->
  Repo.insert_all(User, batch)
end)
