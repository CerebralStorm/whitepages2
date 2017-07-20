defmodule Whitepages2.TableColumnTest do
  use Whitepages2.ModelCase

  alias Whitepages2.TableColumn

  @valid_attrs %{name: "some content", position: 42, table_id: 42}
  @invalid_attrs %{}

  test "changeset with valid attributes" do
    changeset = TableColumn.changeset(%TableColumn{}, @valid_attrs)
    assert changeset.valid?
  end

  test "changeset with invalid attributes" do
    changeset = TableColumn.changeset(%TableColumn{}, @invalid_attrs)
    refute changeset.valid?
  end
end
