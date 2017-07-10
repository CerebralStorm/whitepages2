defmodule Whitepages2.Organization do
  use Whitepages2.Web, :model

  schema "organizations" do
    field :name, :string
    field :key, :string
    field :secret, :string
    field :settings, :string

    timestamps()
  end

  @doc """
  Builds a changeset based on the `struct` and `params`.
  """
  def changeset(struct, params \\ %{}) do
    struct
    |> cast(params, [:name, :key, :secret, :settings])
    |> validate_required([:name, :key, :secret])
  end

  def by_key(query, key) do
    from o in query,
    where: o.key == ^key
  end
end
