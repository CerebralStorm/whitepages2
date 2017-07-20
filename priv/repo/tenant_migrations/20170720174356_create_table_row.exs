defmodule Whitepages2.Repo.TenantMigrations.CreateTableRow do
  use Ecto.Migration

  def change do
    create table(:table_rows) do
      add :table_id, :integer
      add :data, :map

      timestamps()
    end

  end
end
