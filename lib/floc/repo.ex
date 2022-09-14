defmodule Floc.Repo do
  use Ecto.Repo,
    otp_app: :floc,
    adapter: Ecto.Adapters.Postgres
end
