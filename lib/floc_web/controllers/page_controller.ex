defmodule FlocWeb.PageController do
  use FlocWeb, :controller

  def index(conn, _params) do
    render(conn, "index.html", quote: fetch_quote())
  end

  def fetch_quote() do
    {:ok, response} = HTTPoison.get "https://zenquotes.io/api/quotes"
    {:ok, parsed} = response.body |> Jason.decode
    [head | tail] = parsed

    %{text: head["q"], author: head["a"]}
  end
end
