defmodule TavoroMiniWms.Customer do
  use Ecto.Schema
  import Ecto.Changeset

  schema "customers" do
    field :name, :string

    has_many :orders, TavoroMiniWms.Order

    timestamps()
  end

  def create_changeset(attrs) do
    %__MODULE__{}
    |> changeset(attrs)
  end

  def changeset(customer, attrs) do
    customer
    |> cast(attrs, [:name])
    |> validate_required([:name])
  end
end
