ExUnit.start()
ExUnit.configure(exclude: :unreliable)
Ecto.Adapters.SQL.Sandbox.mode(GenApi.Repo, :manual)
