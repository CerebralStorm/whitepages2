defmodule Whitepages2.CourseTest do
  use Whitepages2.ModelCase

  alias Whitepages2.Course

  @valid_attrs %{canvas_course_id: "some content", name: "some content", sis_id: "some content", workflow_state: "some content"}
  @invalid_attrs %{}

  test "changeset with valid attributes" do
    changeset = Course.changeset(%Course{}, @valid_attrs)
    assert changeset.valid?
  end

  test "changeset with invalid attributes" do
    changeset = Course.changeset(%Course{}, @invalid_attrs)
    refute changeset.valid?
  end
end
