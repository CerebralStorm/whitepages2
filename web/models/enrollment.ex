defmodule Whitepages2.Enrollment do
  use Whitepages2.Web, :model

  schema "enrollments" do
    field :canvas_enrollment_id, :string
    belongs_to :course, Whitepages2.Course
    belongs_to :user, Whitepages2.User
    belongs_to :section, Whitepages2.Section
    field :role, :string
    field :enrollment_state, :string

    timestamps()
  end

  @doc """
  Builds a changeset based on the `struct` and `params`.
  """
  def changeset(struct, params \\ %{}) do
    struct
    |> cast(params, [:canvas_enrollment_id, :section_id, :course_id, :role, :enrollment_state])
    |> validate_required([:canvas_enrollment_id, :section_id, :course_id, :role, :enrollment_state])
  end
end
