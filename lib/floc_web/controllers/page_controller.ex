defmodule FlocWeb.PageController do
  use FlocWeb, :controller

  def index(conn, _params) do
    render(conn, "index.html")
  end
end
