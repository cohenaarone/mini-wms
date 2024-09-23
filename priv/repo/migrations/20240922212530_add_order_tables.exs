defmodule TavoroMiniWms.Repo.Migrations.AddOrderTables do
  use Ecto.Migration

  def change do
    create table(:customers) do
      add :name, :string, null: false
      # Pretend more identifying fields are here, including a unique identifier from the real world

      timestamps()
    end

    create index(:customers, [:name])

    create table(:orders) do
      add :status, :string, null: false, default: "pending"
      add :customer_id, references(:customers), null: false

      timestamps()
    end

    create index(:orders, [:customer_id])

    create table(:line_items) do
      add :count, :integer, null: false
      add :order_id, references(:orders), null: false
      add :product_id, references(:products), null: false

      timestamps()
    end

    create unique_index(:line_items, [:order_id, :product_id])
    create index(:line_items, [:product_id])
  end
end
