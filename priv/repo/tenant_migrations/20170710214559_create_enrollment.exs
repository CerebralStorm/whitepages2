defmodule Whitepages2.Repo.TenantMigrations.CreateEnrollment do
  use Ecto.Migration

  def change do
    create table(:enrollments) do
      add :canvas_enrollment_id, :string
      add :section_id, :integer
      add :course_id, :integer
      add :user_id, :integer
      add :role, :string
      add :enrollment_state, :string

      timestamps()
    end

  end
end
