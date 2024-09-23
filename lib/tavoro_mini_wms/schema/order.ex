defmodule TavoroMiniWms.Order do
  use Ecto.Schema
  import Ecto.Changeset

  schema "orders" do
    field :status, :string, default: "pending"

    belongs_to :customer, TavoroMiniWms.Customer
    has_many :line_items, TavoroMiniWms.LineItem

    timestamps()
  end

  def create_changeset(attrs) do
    %__MODULE__{}
    |> changeset(attrs)
  end

  def changeset(order, attrs) do
    order
    |> cast(attrs, [:status, :customer_id])
    |> validate_required([:status, :customer_id])
    |> validate_inclusion(:status, ~w[pending fulfilled])
  end
end
