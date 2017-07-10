defmodule Whitepages2.SectionTest do
  use Whitepages2.ModelCase

  alias Whitepages2.Section

  @valid_attrs %{canvas_section_id: "some content", course_id: 42, name: "some content", sis_id: "some content"}
  @invalid_attrs %{}

  test "changeset with valid attributes" do
    changeset = Section.changeset(%Section{}, @valid_attrs)
    assert changeset.valid?
  end

  test "changeset with invalid attributes" do
    changeset = Section.changeset(%Section{}, @invalid_attrs)
    refute changeset.valid?
  end
end
