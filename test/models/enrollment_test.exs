defmodule Whitepages2.EnrollmentTest do
  use Whitepages2.ModelCase

  alias Whitepages2.Enrollment

  @valid_attrs %{canvas_enrollment_id: "some content", course_id: 42, enrollment_state: "some content", role: "some content", section_id: 42}
  @invalid_attrs %{}

  test "changeset with valid attributes" do
    changeset = Enrollment.changeset(%Enrollment{}, @valid_attrs)
    assert changeset.valid?
  end

  test "changeset with invalid attributes" do
    changeset = Enrollment.changeset(%Enrollment{}, @invalid_attrs)
    refute changeset.valid?
  end
end
