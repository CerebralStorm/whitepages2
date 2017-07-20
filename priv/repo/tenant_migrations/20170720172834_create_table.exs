defmodule Whitepages2.Repo.TenantMigrations.CreateTable do
  use Ecto.Migration

  def change do
    create table(:tables) do
      add :user_id, :integer
      add :course_id, :integer
      add :name, :string

      timestamps()
    end

  end
end
