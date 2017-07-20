defmodule Whitepages2.TableColumnControllerTest do
  use Whitepages2.ConnCase

  alias Whitepages2.TableColumn
  @valid_attrs %{name: "some content", position: 42, table_id: 42}
  @invalid_attrs %{}

  setup %{conn: conn} do
    {:ok, conn: put_req_header(conn, "accept", "application/json")}
  end

  test "lists all entries on index", %{conn: conn} do
    conn = get conn, table_column_path(conn, :index)
    assert json_response(conn, 200)["data"] == []
  end

  test "shows chosen resource", %{conn: conn} do
    table_column = Repo.insert! %TableColumn{}
    conn = get conn, table_column_path(conn, :show, table_column)
    assert json_response(conn, 200)["data"] == %{"id" => table_column.id,
      "table_id" => table_column.table_id,
      "name" => table_column.name,
      "position" => table_column.position}
  end

  test "renders page not found when id is nonexistent", %{conn: conn} do
    assert_error_sent 404, fn ->
      get conn, table_column_path(conn, :show, -1)
    end
  end

  test "creates and renders resource when data is valid", %{conn: conn} do
    conn = post conn, table_column_path(conn, :create), table_column: @valid_attrs
    assert json_response(conn, 201)["data"]["id"]
    assert Repo.get_by(TableColumn, @valid_attrs)
  end

  test "does not create resource and renders errors when data is invalid", %{conn: conn} do
    conn = post conn, table_column_path(conn, :create), table_column: @invalid_attrs
    assert json_response(conn, 422)["errors"] != %{}
  end

  test "updates and renders chosen resource when data is valid", %{conn: conn} do
    table_column = Repo.insert! %TableColumn{}
    conn = put conn, table_column_path(conn, :update, table_column), table_column: @valid_attrs
    assert json_response(conn, 200)["data"]["id"]
    assert Repo.get_by(TableColumn, @valid_attrs)
  end

  test "does not update chosen resource and renders errors when data is invalid", %{conn: conn} do
    table_column = Repo.insert! %TableColumn{}
    conn = put conn, table_column_path(conn, :update, table_column), table_column: @invalid_attrs
    assert json_response(conn, 422)["errors"] != %{}
  end

  test "deletes chosen resource", %{conn: conn} do
    table_column = Repo.insert! %TableColumn{}
    conn = delete conn, table_column_path(conn, :delete, table_column)
    assert response(conn, 204)
    refute Repo.get(TableColumn, table_column.id)
  end
end
