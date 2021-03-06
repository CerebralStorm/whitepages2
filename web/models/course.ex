defmodule Whitepages2.Course do
  use Whitepages2.Web, :model

  schema "courses" do
    field :name, :string
    field :sis_id, :string
    field :workflow_state, :string
    field :canvas_course_id, :string
    has_many :enrollments, Whitepages2.Enrollment
    has_many :users, through: [:enrollments, :user]
    has_many :sections, Whitepages2.Section

    timestamps()
  end

  @doc """
  Builds a changeset based on the `struct` and `params`.
  """
  def changeset(struct, params \\ %{}) do
    struct
    |> cast(params, [:name, :sis_id, :workflow_state, :canvas_course_id])
    |> validate_required([:canvas_course_id])
  end

  def by_canvas_course_id(query, canvas_course_id) do
    from c in query,
    where: c.canvas_course_id == ^canvas_course_id
  end
end
