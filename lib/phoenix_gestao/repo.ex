defmodule PhoenixGestao.Repo do
  use Ecto.Repo,
    otp_app: :phoenix_gestao,
    adapter: Ecto.Adapters.Postgres
end
