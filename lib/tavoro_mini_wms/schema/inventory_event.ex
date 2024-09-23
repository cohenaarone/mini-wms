defmodule TavoroMiniWms.InventoryEvent do
  use Ecto.Schema
  import Ecto.Changeset

  @primary_key false
  schema "inventory_events" do
    field :change_count, :integer
    field :event, :string

    belongs_to :location, TavoroMiniWms.Location
    belongs_to :product, TavoroMiniWms.Product

    timestamps()
  end

  def create_changeset(attrs) do
    %__MODULE__{}
    |> changeset(attrs)
  end

  def changeset(inventory_event, attrs) do
    inventory_event
    |> cast(attrs, [:change_count, :event, :product_id, :location_id])
    |> validate_required([:change_count, :event, :product_id, :location_id])
    |> validate_number(:count, not_equal_to: 0)
    |> validate_inclusion(:event, ~w[added moved removed])
  end
end
