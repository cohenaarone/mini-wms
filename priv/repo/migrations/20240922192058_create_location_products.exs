defmodule TavoroMiniWms.Repo.Migrations.CreateLocationProducts do
  use Ecto.Migration

  def change do
    create table(:location_products, primary_key: false) do
      add :count, :integer, null: false, default: 0
      add :location_id, references(:locations), null: false
      add :product_id, references(:products), null: false

      timestamps()
    end

    create index(:location_products, [:location_id])
    create unique_index(:location_products, [:product_id, :location_id])
  end
end
