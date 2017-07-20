defmodule Whitepages2.TableRowTest do
  use Whitepages2.ModelCase

  alias Whitepages2.TableRow

  @valid_attrs %{data: %{}, table_id: 42}
  @invalid_attrs %{}

  test "changeset with valid attributes" do
    changeset = TableRow.changeset(%TableRow{}, @valid_attrs)
    assert changeset.valid?
  end

  test "changeset with invalid attributes" do
    changeset = TableRow.changeset(%TableRow{}, @invalid_attrs)
    refute changeset.valid?
  end
end
