defmodule TavoroMiniWms.LocationProduct do
  use Ecto.Schema
  import Ecto.Changeset

  @primary_key false
  schema "location_products" do
    field :count, :integer

    belongs_to :location, TavoroMiniWms.Location
    belongs_to :product, TavoroMiniWms.Product

    timestamps()
  end

  def create_changeset(attrs) do
    %__MODULE__{}
    |> changeset(attrs)
  end

  def changeset(location_products, attrs) do
    location_products
    |> cast(attrs, [:count, :product_id, :location_id])
    |> validate_required([:count, :product_id, :location_id])
    |> validate_number(:count, greater_than_or_equal_to: 0)
  end
end
