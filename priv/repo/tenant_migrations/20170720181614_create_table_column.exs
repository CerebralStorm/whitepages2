defmodule Whitepages2.Repo.TenantMigrations.CreateTableColumn do
  use Ecto.Migration

  def change do
    create table(:table_columns) do
      add :table_id, :integer
      add :name, :string
      add :position, :integer

      timestamps()
    end

  end
end
