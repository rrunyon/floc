defmodule FlocWeb.PageController do
  use FlocWeb, :controller

  def index(conn, _params) do
    render(conn, "index.html", quote: nil)
  end

  def fetch_quote() do
    case Cachex.get!(:cache, "quote") do
      nil ->
        {:ok, response} = HTTPoison.get "https://zenquotes.io/api/quotes"
        {:ok, parsed} = response.body |> Jason.decode
        [head | _tail] = parsed

        Cachex.put(:cache, "quote", %{text: head["q"], author: head["a"]}, ttl: 5000)
      _ ->
    end

    Cachex.get!(:cache, "quote")
  end
end
