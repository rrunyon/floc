defmodule Floc.Season do
  use Ecto.Schema

  @primary_key {:id, Ecto.UUID, autogenerate: true}

  schema "seasons" do
    belongs_to :first_place, Floc.User
    belongs_to :second_place, Floc.User
    belongs_to :third_place, Floc.User
    belongs_to :last_place, Floc.User

    field :year, :string
    field :buy_in, :integer
    field :payouts, {:array, :integer}

    timestamps()
  end
end
