defmodule Floc.Espn do
  use Memoize

  @base_url "https://fantasy.espn.com/apis/v3/games/ffl/leagueHistory/831039?view=mTeam&view=mMatchupScore" 

  defmemo fetch_data do
    {:ok, response} = HTTPoison.get @base_url
    {:ok, parsed} = response.body |> Jason.decode

    parsed
  end

  def parse_members do
    fetch_data()
    |> Enum.flat_map(fn o -> o["members"] end) 
    |> Enum.reduce(%{}, fn member, acc -> acc |> Map.put_new(member["id"], member) end)
    |> Map.values
    |> Enum.map(fn member -> parse_user(member) end)
  end

  def insert_members do
    parse_members() 
    |> Enum.each(fn member -> Floc.Repo.insert(member) end)
  end

  def parse_seasons do
    fetch_data() 
    |> Enum.map(fn o -> o["seasonId"] end)
  end

  def insert_seasons do
    parse_seasons() 
    |> Enum.each(fn year -> Floc.Repo.insert(%Floc.Season{year: to_string(year)}) end)
  end

  def parse_teams do
    fetch_data() 
    |> Enum.reduce(%{}, fn o, acc -> acc |> Map.put_new(o["seasonId"], o["teams"]) end)
  end

  def insert_teams do
  end

  def parse_matchups do
  end

  defp parse_user(raw_member) do
    %Floc.User{
      espn_raw: raw_member,
      espn_id: raw_member["id"],
      first_name: raw_member["firstName"],
      last_name: raw_member["lastName"]
    }
  end

  defp parse_team(raw_team) do
    %Floc.Team{
      espn_raw: raw_team,
      espn_id: raw_team["id"],
      name: raw_team["location"] <> " " <> raw_team["nickname"],
      avatar_url: raw_team["logo"]
    }
  end
end
