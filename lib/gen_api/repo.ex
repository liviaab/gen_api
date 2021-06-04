defmodule GenApi.Repo do
  use Ecto.Repo,
    otp_app: :gen_api,
    adapter: Ecto.Adapters.Postgres
end
