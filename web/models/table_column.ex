defmodule Whitepages2.TableColumn do
  use Whitepages2.Web, :model

  schema "table_columns" do
    field :table_id, :integer
    field :name, :string
    field :position, :integer

    timestamps()
  end

  @doc """
  Builds a changeset based on the `struct` and `params`.
  """
  def changeset(struct, params \\ %{}) do
    struct
    |> cast(params, [:table_id, :name, :position])
    |> validate_required([:table_id, :name, :position])
  end
end
