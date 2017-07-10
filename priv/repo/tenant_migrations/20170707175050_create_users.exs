defmodule Whitepages2.Repo.TenantMigrations.CreateUsers do
  use Ecto.Migration

  def change do
    create table(:users) do
      add :canvas_user_id, :string
      add :sis_id, :string
      add :data, :string

      timestamps()
    end
  end
end
