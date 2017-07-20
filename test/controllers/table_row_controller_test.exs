defmodule Whitepages2.TableRowControllerTest do
  use Whitepages2.ConnCase

  alias Whitepages2.TableRow
  @valid_attrs %{data: %{}, table_id: 42}
  @invalid_attrs %{}

  setup %{conn: conn} do
    {:ok, conn: put_req_header(conn, "accept", "application/json")}
  end

  test "lists all entries on index", %{conn: conn} do
    conn = get conn, table_row_path(conn, :index)
    assert json_response(conn, 200)["data"] == []
  end

  test "shows chosen resource", %{conn: conn} do
    table_row = Repo.insert! %TableRow{}
    conn = get conn, table_row_path(conn, :show, table_row)
    assert json_response(conn, 200)["data"] == %{"id" => table_row.id,
      "table_id" => table_row.table_id,
      "data" => table_row.data}
  end

  test "renders page not found when id is nonexistent", %{conn: conn} do
    assert_error_sent 404, fn ->
      get conn, table_row_path(conn, :show, -1)
    end
  end

  test "creates and renders resource when data is valid", %{conn: conn} do
    conn = post conn, table_row_path(conn, :create), table_row: @valid_attrs
    assert json_response(conn, 201)["data"]["id"]
    assert Repo.get_by(TableRow, @valid_attrs)
  end

  test "does not create resource and renders errors when data is invalid", %{conn: conn} do
    conn = post conn, table_row_path(conn, :create), table_row: @invalid_attrs
    assert json_response(conn, 422)["errors"] != %{}
  end

  test "updates and renders chosen resource when data is valid", %{conn: conn} do
    table_row = Repo.insert! %TableRow{}
    conn = put conn, table_row_path(conn, :update, table_row), table_row: @valid_attrs
    assert json_response(conn, 200)["data"]["id"]
    assert Repo.get_by(TableRow, @valid_attrs)
  end

  test "does not update chosen resource and renders errors when data is invalid", %{conn: conn} do
    table_row = Repo.insert! %TableRow{}
    conn = put conn, table_row_path(conn, :update, table_row), table_row: @invalid_attrs
    assert json_response(conn, 422)["errors"] != %{}
  end

  test "deletes chosen resource", %{conn: conn} do
    table_row = Repo.insert! %TableRow{}
    conn = delete conn, table_row_path(conn, :delete, table_row)
    assert response(conn, 204)
    refute Repo.get(TableRow, table_row.id)
  end
end
