defmodule Whitepages2.EnrollmentControllerTest do
  use Whitepages2.ConnCase

  alias Whitepages2.Enrollment
  @valid_attrs %{canvas_enrollment_id: "some content", course_id: 42, enrollment_state: "some content", role: "some content", section_id: 42}
  @invalid_attrs %{}

  setup %{conn: conn} do
    {:ok, conn: put_req_header(conn, "accept", "application/json")}
  end

  test "lists all entries on index", %{conn: conn} do
    conn = get conn, enrollment_path(conn, :index)
    assert json_response(conn, 200)["data"] == []
  end

  test "shows chosen resource", %{conn: conn} do
    enrollment = Repo.insert! %Enrollment{}
    conn = get conn, enrollment_path(conn, :show, enrollment)
    assert json_response(conn, 200)["data"] == %{"id" => enrollment.id,
      "canvas_enrollment_id" => enrollment.canvas_enrollment_id,
      "section_id" => enrollment.section_id,
      "course_id" => enrollment.course_id,
      "role" => enrollment.role,
      "enrollment_state" => enrollment.enrollment_state}
  end

  test "renders page not found when id is nonexistent", %{conn: conn} do
    assert_error_sent 404, fn ->
      get conn, enrollment_path(conn, :show, -1)
    end
  end

  test "creates and renders resource when data is valid", %{conn: conn} do
    conn = post conn, enrollment_path(conn, :create), enrollment: @valid_attrs
    assert json_response(conn, 201)["data"]["id"]
    assert Repo.get_by(Enrollment, @valid_attrs)
  end

  test "does not create resource and renders errors when data is invalid", %{conn: conn} do
    conn = post conn, enrollment_path(conn, :create), enrollment: @invalid_attrs
    assert json_response(conn, 422)["errors"] != %{}
  end

  test "updates and renders chosen resource when data is valid", %{conn: conn} do
    enrollment = Repo.insert! %Enrollment{}
    conn = put conn, enrollment_path(conn, :update, enrollment), enrollment: @valid_attrs
    assert json_response(conn, 200)["data"]["id"]
    assert Repo.get_by(Enrollment, @valid_attrs)
  end

  test "does not update chosen resource and renders errors when data is invalid", %{conn: conn} do
    enrollment = Repo.insert! %Enrollment{}
    conn = put conn, enrollment_path(conn, :update, enrollment), enrollment: @invalid_attrs
    assert json_response(conn, 422)["errors"] != %{}
  end

  test "deletes chosen resource", %{conn: conn} do
    enrollment = Repo.insert! %Enrollment{}
    conn = delete conn, enrollment_path(conn, :delete, enrollment)
    assert response(conn, 204)
    refute Repo.get(Enrollment, enrollment.id)
  end
end
