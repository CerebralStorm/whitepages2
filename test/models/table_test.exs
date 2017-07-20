defmodule Whitepages2.TableTest do
  use Whitepages2.ModelCase

  alias Whitepages2.Table

  @valid_attrs %{course_id: 42, name: "some content", user_id: 42}
  @invalid_attrs %{}

  test "changeset with valid attributes" do
    changeset = Table.changeset(%Table{}, @valid_attrs)
    assert changeset.valid?
  end

  test "changeset with invalid attributes" do
    changeset = Table.changeset(%Table{}, @invalid_attrs)
    refute changeset.valid?
  end
end
