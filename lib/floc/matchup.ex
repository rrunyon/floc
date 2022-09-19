defmodule Floc.Matchup do
  use Ecto.Schema

  schema "matchups" do
    field :espn_raw, :map

    belongs_to :home_team, Floc.User
    belongs_to :away_team, Floc.User
    field :home_score, :string
    field :away_score, :string
    field :playoff_tier_type, :string

    timestamps()
  end
end
