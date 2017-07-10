defmodule Whitepages2.Repo.TenantMigrations.CreateCourse do
  use Ecto.Migration

  def change do
    create table(:courses) do
      add :name, :string
      add :sis_id, :string
      add :workflow_state, :string
      add :canvas_course_id, :string

      timestamps()
    end

  end
end
