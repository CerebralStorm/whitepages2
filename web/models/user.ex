defmodule Whitepages2.User do
  use Whitepages2.Web, :model

  schema "users" do
    field :canvas_user_id, :string
    field :sis_id, :string
    field :data, :string
    has_many :tables, Whitepages2.Table

    timestamps()
  end

  @doc """
  Builds a changeset based on the `struct` and `params`.
  """
  def changeset(struct, params \\ %{}) do
    struct
    |> cast(params, [:canvas_user_id, :sis_id, :data])
    |> validate_required([:canvas_user_id, :sis_id, :data])
  end
end
