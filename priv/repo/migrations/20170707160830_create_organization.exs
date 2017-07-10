defmodule Whitepages2.Repo.Migrations.CreateOrganization do
  use Ecto.Migration

  def change do
    create table(:organizations) do
      add :name, :string
      add :key, :string
      add :secret, :string
      add :settings, :map

      timestamps()
    end

  end
end
