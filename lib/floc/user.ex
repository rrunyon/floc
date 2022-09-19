defmodule Floc.User do
  use Ecto.Schema

  @primary_key {:id, Ecto.UUID, autogenerate: true}

  schema "users" do
    field :espn_raw, :map

    field :espn_id, :string
    field :first_name, :string
    field :last_name, :string
    field :email, :string

    timestamps()
  end
end
