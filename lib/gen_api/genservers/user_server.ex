defmodule GenApi.GenServers.UserServer do
  @moduledoc """
  This is the genserver retrives two users, its points and the last timestamp 
    when there is a call to the main endpoint.
  It also updates the users points every minute.
  """ 
  use GenServer

  require Logger

  alias GenApi.Users

  # Client

  def start_link(_) do
    GenServer.start_link(__MODULE__, nil, name: UserServer)
  end

  def get_users() do
    GenServer.call(UserServer, :get_users)
  end

  # Server (callbacks)

  @impl true
  def init(_) do
    Logger.info("Init UserServer")
    schedule_work()

    {:ok, {Enum.random(0..100), nil}}
  end

  @impl true
  def handle_call(:get_users, _from, state) do
    {previous_max_number, previous_timestamp} = state

    users = Users.list_users(%{limit: 2, min_points: previous_max_number})
    new_timestamp = DateTime.utc_now()

    Logger.info(
      "UserServer called\n" <>
        "Previous state\tmax_points: #{previous_max_number} timestamp: #{previous_timestamp}\n" <>
        "New state\tmax_points: #{previous_max_number} timestamp: #{new_timestamp}\n\n"
    )

    {:reply, {users, previous_timestamp}, {previous_max_number, new_timestamp}}
  end

  @impl true
  def handle_info(:update, state) do
    Logger.info("Update UserServer")

    {max_points, timestamp} = state
    # Updates every user's points in the database
    Users.update_all_users_points()

    # Updates max_points
    new_max_points = Enum.random(0..100)

    Logger.info(
      "UserServer Scheduled Work\n" <>
        "Previous state\tmax_points: #{max_points} timestamp: #{timestamp}\n" <>
        "New state\tmax_points: #{new_max_points} timestamp: #{timestamp}\n\n"
    )

    schedule_work()

    {:noreply, {new_max_points, timestamp}}
  end

  defp schedule_work do
    # We schedule the work to happen every minute
    Logger.info("Scheduling work")

    Process.send_after(self(), :update, :timer.minutes(1))
  end
end
