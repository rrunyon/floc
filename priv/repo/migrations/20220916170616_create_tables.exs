defmodule Floc.Repo.Migrations.CreateTables do
  use Ecto.Migration

  def change do
    create table(:users) do
      add :espn_raw, :jsonb, null: false

      add :first_name, :string
      add :last_name, :string
      add :email, :string

      timestamps()
    end

    create table(:teams) do
      add :espn_raw, :jsonb, null: false

      add :user_id, references(:users)
      add :name, :string
      add :avatar_url, :string

      timestamps()
    end

    create index(:teams, [:user_id])

    create table(:seasons) do
      add :year, :integer, null: false
      add :first_place_id, references(:users), null: false
      add :second_place_id, references(:users), null: false
      add :third_place_id, references(:users), null: false
      add :last_place_id, references(:users), null: false
      add :buy_in, :integer
      add :payouts, {:array, :integer}

      timestamps()
    end

    create index(:seasons, [:first_place_id])
    create index(:seasons, [:second_place_id])
    create index(:seasons, [:third_place_id])
    create index(:seasons, [:last_place_id])

    create table(:weeks) do
      add :season_id, references(:seasons), null: false
      add :playoff, :boolean, default: false, null: false
      add :recap, :text

      timestamps()
    end

    create index(:weeks, [:season_id])

    create table(:matchups) do
      add :espn_raw, :jsonb, null: false

      add :week_id, references(:weeks)
      add :season_id, references(:seasons)
      add :home_team_id, references(:teams)
      add :away_team_id, references(:teams)
      add :home_score, :string, null: false
      add :away_score, :string, null: false
      add :playoff_tier_type, :string, null: false

      timestamps()
    end

    create index(:matchups, [:week_id])
    create index(:matchups, [:season_id])
    create index(:matchups, [:home_team_id])
    create index(:matchups, [:away_team_id])
  end
end
