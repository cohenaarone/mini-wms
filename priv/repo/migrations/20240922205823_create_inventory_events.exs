defmodule TavoroMiniWms.Repo.Migrations.CreateInventoryEvents do
  use Ecto.Migration

  def change do
    create table(:inventory_events) do
      add :change_count, :integer, null: false
      add :event, :string, null: false
      add :location_id, references(:locations), null: false
      add :product_id, references(:products), null: false

      timestamps()
    end

    create index(:inventory_events, [:location_id])
    create index(:inventory_events, [:product_id])
  end
end
