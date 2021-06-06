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

alias GenApi.Users

Enum.map(1..1_000_000, fn _ ->
  Users.create_user(%{points: 0})
end)
