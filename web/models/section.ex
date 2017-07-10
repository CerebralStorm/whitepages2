defmodule Whitepages2.Section do
  use Whitepages2.Web, :model

  schema "sections" do
    field :canvas_section_id, :string
    field :sis_id, :string
    belongs_to :course, Whitepages2.Course
    field :name, :string

    timestamps()
  end

  @doc """
  Builds a changeset based on the `struct` and `params`.
  """
  def changeset(struct, params \\ %{}) do
    struct
    |> cast(params, [:canvas_section_id, :sis_id, :course_id, :name])
    |> validate_required([:canvas_section_id, :sis_id, :course_id, :name])
  end
end
