defmodule TavoroMiniWmsWeb.OrderJSON do
  alias TavoroMiniWms.Order

  @doc """
  Renders a list of orders.
  """
  def index(%{orders: orders}) do
    %{data: for(order <- orders, do: data(order))}
  end

  @doc """
  Renders a single order.
  """
  def show(%{order: order}) do
    %{data: data(order)}
  end

  defp data(%Order{} = order) do
    %{
      id: order.id,
      status: order.status,
      customer_name: order.customer.name,
      line_items: line_item_data(order.line_items)
    }
  end

  defp line_item_data(line_items) do
    for(line_item <- line_items, do: line_item_datum(line_item))
  end

  defp line_item_datum(line_item) do
    product = line_item.product
    %{
      count: line_item.count,
      product_name: product.name,
      product_sku: product.sku,
      product_price: product.price
    }
  end
end
