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
    create unique_index(:inventory_events, [:product_id, :location_id])
  end
end
