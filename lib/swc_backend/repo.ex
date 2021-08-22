defmodule SwcBackend.Repo do
  use Ecto.Repo,
    otp_app: :swc_backend,
    adapter: Ecto.Adapters.Postgres
end
