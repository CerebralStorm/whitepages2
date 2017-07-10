defmodule Whitepages2.Course do
  use Whitepages2.Web, :model

  schema "courses" do
    field :name, :string
    field :sis_id, :string
    field :workflow_state, :string
    field :canvas_course_id, :string

    timestamps()
  end

  @doc """
  Builds a changeset based on the `struct` and `params`.
  """
  def changeset(struct, params \\ %{}) do
    struct
    |> cast(params, [:name, :sis_id, :workflow_state, :canvas_course_id])
    |> validate_required([:name, :sis_id, :workflow_state, :canvas_course_id])
  end
end
