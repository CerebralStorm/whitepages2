defmodule Whitepages2.Table do
  use Whitepages2.Web, :model

  schema "tables" do
    belongs_to :user, Whitepages2.User
    belongs_to :course, Whitepages2.Course
    field :name, :string

    timestamps()
  end

  @doc """
  Builds a changeset based on the `struct` and `params`.
  """
  def changeset(struct, params \\ %{}) do
    struct
    |> cast(params, [:user_id, :course_id, :name])
    |> validate_required([:course_id, :name])
  end
end
