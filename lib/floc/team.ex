defmodule Floc.Team do
  use Ecto.Schema

  @primary_key {:id, Ecto.UUID, autogenerate: true}

  schema "users" do
    belongs_to :user, Floc.User

    field :espn_raw, :map
    field :espn_id, :string
    field :name, :string
    field :avatar_url, :string

    timestamps()
  end
end
