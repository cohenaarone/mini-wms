defmodule TavoroMiniWmsWeb.OrderController do

  use TavoroMiniWmsWeb, :controller

  alias TavoroMiniWms.{Repo, Order}

  action_fallback TavoroMiniWmsWeb.FallbackController

  import Ecto.Query

  def index(conn, _params) do
    # Preload belongs_to via main query, but preload LineItem stuff via additional queries to avoid bloating result set
    orders =
      from(o in Order, join: c in assoc(o, :customer), preload: [customer: c])
      |> Repo.all()
      |> Repo.preload(line_items: [:product])
    render(conn, :index, orders: orders)
  end

  def create(conn, %{"order" => order_params}) do
    with {:ok, %Order{} = order} <- Order.create_changeset(order_params) |> Repo.insert() do
      conn
      |> put_status(:created)
      |> put_resp_header("location", ~p"/api/orders/#{order}")
      |> render(:show, order: order)
    end
  end

  def update(conn, %{"id" => id, "order" => order_params}) do
    order = Repo.get(Order, id)

    with {:ok, %Order{} = order} <-
    Order.changeset(order, order_params) |> Repo.update() do
      render(conn, :show, order: order)
    end
  end

end
