defmodule LiveWeb.Repo do
  use Ecto.Repo,
    otp_app: :live_web,
    adapter: Ecto.Adapters.Postgres
end
