defmodule TavoroMiniWmsWeb.OrderControllerTest do
  use TavoroMiniWmsWeb.ConnCase

  alias TavoroMiniWms.{Repo, Order, Customer, LineItem, Product}

  # @create_attrs %{
  #   name: "some name",
  #   price: "120.5",
  #   sku: "some sku"
  # }
  # @update_attrs %{
  #   name: "some updated name",
  #   price: "456.7",
  #   sku: "some updated sku"
  # }
  # @invalid_attrs %{name: nil, price: nil, sku: nil}

  setup %{conn: conn} do
    {:ok, conn: put_req_header(conn, "accept", "application/json")}
  end

  describe "index" do
    test "lists all orders", %{conn: conn} do
      create_order(:bah)
      conn = get(conn, ~p"/api/orders")
      [data | tail] = json_response(conn, 200)["data"]
      data = Map.delete(data, "id")
      assert data == expected_order()
    end
  end

  # describe "create order" do
  #   test "renders order when data is valid", %{conn: conn} do
  #     conn = post(conn, ~p"/api/orders", order: @create_attrs)
  #     assert %{"id" => id} = json_response(conn, 201)["data"]

  #     conn = get(conn, ~p"/api/orders/#{id}")

  #     assert %{
  #       "id" => ^id,
  #       "name" => "some name",
  #       "price" => "120.5",
  #       "sku" => "some sku"
  #     } = json_response(conn, 200)["data"]
  #   end

  #   @tag :skip
  #   test "renders errors when data is invalid", %{conn: conn} do
  #     conn = post(conn, ~p"/api/orders", order: @invalid_attrs)
  #     assert json_response(conn, 422)["errors"] != %{}
  #   end
  # end

  # describe "update order" do
  #   setup [:create_order]

  #   test "renders order when data is valid", %{conn: conn, order: %Order{id: id} = order} do
  #     conn = put(conn, ~p"/api/orders/#{order}", order: @update_attrs)
  #     assert %{"id" => ^id} = json_response(conn, 200)["data"]

  #     conn = get(conn, ~p"/api/orders/#{id}")

  #     assert %{
  #       "id" => ^id,
  #       "name" => "some updated name",
  #       "price" => "456.7",
  #       "sku" => "some updated sku"
  #     } = json_response(conn, 200)["data"]
  #   end

  #   @tag :skip
  #   test "renders errors when data is invalid", %{conn: conn, order: order} do
  #     conn = put(conn, ~p"/api/orders/#{order}", order: @invalid_attrs)
  #     assert json_response(conn, 422)["errors"] != %{}
  #   end
  # end

  # In real life, I'd use whatever is closest to FactoryBot for Ruby; really hope one of the ones I saw online rocks
  defp create_order(_) do
    customer =
      Customer.create_changeset(%{name: "Whatever"})
      |> Repo.insert!()

    order =
      Order.create_changeset(%{customer_id: customer.id})
      |> Repo.insert!()

    product_1 =
      Product.create_changeset(
        %{
          name: "Product 1",
          sku: "111111111",
          price: 111.11
        }
      )
      |> Repo.insert!()

    LineItem.create_changeset(
      %{
        count: 5,
        product_id: product_1.id,
        order_id: order.id
      }
    )
    |> Repo.insert!()

    product_2 =
      Product.create_changeset(
        %{
          name: "Product 2",
          sku: "222222222",
          price: 222.22
        }
      )
      |> Repo.insert!()

    LineItem.create_changeset(
      %{
        count: 10,
        product_id: product_2.id,
        order_id: order.id
      }
    )
    |> Repo.insert!()

    %{order: order}
  end

  defp expected_order do
    %{
      "customer_name" => "Whatever",
      "status" => "pending",
      "line_items" => [
        %{
          "count" => 5,
          "product_name" => "Product 1",
          "product_price" => "111.11",
          "product_sku" => "111111111"
        },
        %{
          "count" => 10,
          "product_name" => "Product 2",
          "product_price" => "222.22",
          "product_sku" => "222222222"
        }
      ]
    }
  end

end
