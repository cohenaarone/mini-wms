defmodule TavoroMiniWms.LineItem do
  use Ecto.Schema
  import Ecto.Changeset

  schema "line_items" do
    field :count, :integer

    belongs_to :order, TavoroMiniWms.Order
    belongs_to :product, TavoroMiniWms.Product

    timestamps()
  end

  def create_changeset(attrs) do
    %__MODULE__{}
    |> changeset(attrs)
  end

  def changeset(line_item, attrs) do
    line_item
    |> cast(attrs, [:count, :customer_id, :product_id])
    |> validate_required([:count, :customer_id, :product_id])
    |> validate_number(:count, greater_than: 0)
  end
end
