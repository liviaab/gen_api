defmodule GenApi.GenServers.UserServerMock do
  @moduledoc """
  Mocks genserver UserServer
  """

  alias GenApi.Users

  @table_name :user_server

  def init() do 
    :ets.new(@table_name , [:named_table, :set])
    :ets.insert(@table_name , {:timestamp, nil})
    :ok
  end

  def get_users() do
    users = Users.list_users(%{limit: 2, min_points: 30})
    [{_field_name, timestamp}] = :ets.lookup(@table_name, :timestamp)

    now = NaiveDateTime.utc_now() |> NaiveDateTime.truncate(:second) |> NaiveDateTime.to_string()
    :ets.insert(@table_name , {:timestamp, now})

    {users, timestamp}
  end
end