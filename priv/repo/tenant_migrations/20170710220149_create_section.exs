defmodule Whitepages2.Repo.TenantMigrations.CreateSection do
  use Ecto.Migration

  def change do
    create table(:sections) do
      add :canvas_section_id, :string
      add :sis_id, :string
      add :course_id, :integer
      add :name, :string

      timestamps()
    end

  end
end
