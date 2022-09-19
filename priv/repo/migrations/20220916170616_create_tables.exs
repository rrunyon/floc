defmodule Floc.Repo.Migrations.CreateTables do
  use Ecto.Migration

  def change do
    create table(:users) do
      add :name, :string, null: false
      add :email, :string, null: false

      timestamps()
    end

    create table(:teams) do
      add :user_id, references(:users, on_delete: :nothing), null: false
      add :name, :string, null: false
      add :avatar_url, :string, null: false

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
      add :week_id, references(:weeks), null: false
      add :season_id, references(:seasons), null: false
      add :home_team_id, references(:teams), null: false
      add :away_team_id, references(:teams), null: false
      add :score, :string, null: false
      add :playoff, :boolean, null: false, default: false

      timestamps()
    end

    create index(:matchups, [:week_id])
    create index(:matchups, [:season_id])
    create index(:matchups, [:home_team_id])
    create index(:matchups, [:away_team_id])
  end
end
