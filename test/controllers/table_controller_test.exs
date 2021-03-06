defmodule Whitepages2.TableControllerTest do
  use Whitepages2.ConnCase

  alias Whitepages2.Table
  @valid_attrs %{course_id: 42, name: "some content", user_id: 42}
  @invalid_attrs %{}

  setup %{conn: conn} do
    {:ok, conn: put_req_header(conn, "accept", "application/json")}
  end

  test "lists all entries on index", %{conn: conn} do
    conn = get conn, table_path(conn, :index)
    assert json_response(conn, 200)["data"] == []
  end

  test "shows chosen resource", %{conn: conn} do
    table = Repo.insert! %Table{}
    conn = get conn, table_path(conn, :show, table)
    assert json_response(conn, 200)["data"] == %{"id" => table.id,
      "user_id" => table.user_id,
      "course_id" => table.course_id,
      "name" => table.name}
  end

  test "renders page not found when id is nonexistent", %{conn: conn} do
    assert_error_sent 404, fn ->
      get conn, table_path(conn, :show, -1)
    end
  end

  test "creates and renders resource when data is valid", %{conn: conn} do
    conn = post conn, table_path(conn, :create), table: @valid_attrs
    assert json_response(conn, 201)["data"]["id"]
    assert Repo.get_by(Table, @valid_attrs)
  end

  test "does not create resource and renders errors when data is invalid", %{conn: conn} do
    conn = post conn, table_path(conn, :create), table: @invalid_attrs
    assert json_response(conn, 422)["errors"] != %{}
  end

  test "updates and renders chosen resource when data is valid", %{conn: conn} do
    table = Repo.insert! %Table{}
    conn = put conn, table_path(conn, :update, table), table: @valid_attrs
    assert json_response(conn, 200)["data"]["id"]
    assert Repo.get_by(Table, @valid_attrs)
  end

  test "does not update chosen resource and renders errors when data is invalid", %{conn: conn} do
    table = Repo.insert! %Table{}
    conn = put conn, table_path(conn, :update, table), table: @invalid_attrs
    assert json_response(conn, 422)["errors"] != %{}
  end

  test "deletes chosen resource", %{conn: conn} do
    table = Repo.insert! %Table{}
    conn = delete conn, table_path(conn, :delete, table)
    assert response(conn, 204)
    refute Repo.get(Table, table.id)
  end
end
