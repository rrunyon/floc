defmodule Floc.Repo.Migrations.CreateTables do
  use Ecto.Migration

  def change do
    create table(:users) do
      add :espn_raw, :jsonb, null: false

      add :espn_id, :string, null: false
      add :first_name, :string
      add :last_name, :string
      add :email, :string

      timestamps()
    end

    create unique_index(:users, [:espn_id])

    create table(:seasons) do
      add :year, :string, null: false
      add :first_place_id, references(:users)
      add :second_place_id, references(:users)
      add :third_place_id, references(:users)
      add :last_place_id, references(:users)
      add :buy_in, :integer
      add :payouts, {:array, :integer}

      timestamps()
    end

    create index(:seasons, [:first_place_id])
    create index(:seasons, [:second_place_id])
    create index(:seasons, [:third_place_id])
    create index(:seasons, [:last_place_id])

    create unique_index(:seasons, [:year])

    create table(:teams) do
      add :espn_raw, :jsonb, null: false

      add :espn_id, :string, null: false
      add :user_id, references(:users)
      add :season_id, references(:seasons)
      add :name, :string
      add :avatar_url, :string

      timestamps()
    end

    create unique_index(:teams, [:user_id, :season_id])

    create table(:weeks) do
      add :season_id, references(:seasons), null: false
      add :week, :integer, null: false
      add :playoff, :boolean, default: false, null: false
      add :recap, :text

      timestamps()
    end

    create unique_index(:weeks, [:season_id, :week])

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

    create unique_index(:matchups, [:week_id, :season_id, :home_team_id, :away_team_id])
  end
end
