defmodule Whitepages2.SectionControllerTest do
  use Whitepages2.ConnCase

  alias Whitepages2.Section
  @valid_attrs %{canvas_section_id: "some content", course_id: 42, name: "some content", sis_id: "some content"}
  @invalid_attrs %{}

  setup %{conn: conn} do
    {:ok, conn: put_req_header(conn, "accept", "application/json")}
  end

  test "lists all entries on index", %{conn: conn} do
    conn = get conn, section_path(conn, :index)
    assert json_response(conn, 200)["data"] == []
  end

  test "shows chosen resource", %{conn: conn} do
    section = Repo.insert! %Section{}
    conn = get conn, section_path(conn, :show, section)
    assert json_response(conn, 200)["data"] == %{"id" => section.id,
      "canvas_section_id" => section.canvas_section_id,
      "sis_id" => section.sis_id,
      "course_id" => section.course_id,
      "name" => section.name}
  end

  test "renders page not found when id is nonexistent", %{conn: conn} do
    assert_error_sent 404, fn ->
      get conn, section_path(conn, :show, -1)
    end
  end

  test "creates and renders resource when data is valid", %{conn: conn} do
    conn = post conn, section_path(conn, :create), section: @valid_attrs
    assert json_response(conn, 201)["data"]["id"]
    assert Repo.get_by(Section, @valid_attrs)
  end

  test "does not create resource and renders errors when data is invalid", %{conn: conn} do
    conn = post conn, section_path(conn, :create), section: @invalid_attrs
    assert json_response(conn, 422)["errors"] != %{}
  end

  test "updates and renders chosen resource when data is valid", %{conn: conn} do
    section = Repo.insert! %Section{}
    conn = put conn, section_path(conn, :update, section), section: @valid_attrs
    assert json_response(conn, 200)["data"]["id"]
    assert Repo.get_by(Section, @valid_attrs)
  end

  test "does not update chosen resource and renders errors when data is invalid", %{conn: conn} do
    section = Repo.insert! %Section{}
    conn = put conn, section_path(conn, :update, section), section: @invalid_attrs
    assert json_response(conn, 422)["errors"] != %{}
  end

  test "deletes chosen resource", %{conn: conn} do
    section = Repo.insert! %Section{}
    conn = delete conn, section_path(conn, :delete, section)
    assert response(conn, 204)
    refute Repo.get(Section, section.id)
  end
end
