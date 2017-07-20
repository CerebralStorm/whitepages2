defmodule Whitepages2.TableRowController do
  use Whitepages2.Web, :controller

  alias Whitepages2.TableRow

  def index(conn, %{"organization_id" => organization_id}) do
    table_rows = Apartmentex.all(Repo, TableRow, organization_id)
    render(conn, "index.json", table_rows: table_rows)
  end

  def create(conn, %{"table_row" => table_row_params, "organization_id" => organization_id, "table_id" => table_id}) do
    changeset = TableRow.changeset(%TableRow{}, table_row_params)

    case Apartmentex.insert(Repo, changeset, organization_id) do
      {:ok, table_row} ->
        conn
        |> put_status(:created)
        |> put_resp_header("location", organization_table_table_row_path(conn, :show, table_row, organization_id, table_id))
        |> render("show.json", table_row: table_row)
      {:error, changeset} ->
        conn
        |> put_status(:unprocessable_entity)
        |> render(Whitepages2.ChangesetView, "error.json", changeset: changeset)
    end
  end

  def show(conn, %{"id" => id, "organization_id" => organization_id}) do
    table_row = Apartmentex.get!(Repo, TableRow, id, organization_id)
    render(conn, "show.json", table_row: table_row)
  end

  def update(conn, %{"id" => id, "organization_id" => organization_id, "table_row" => table_row_params}) do
    table_row = Apartmentex.get!(Repo, TableRow, id, organization_id)
    changeset = TableRow.changeset(table_row, table_row_params)

    case Repo.update(changeset) do
      {:ok, table_row} ->
        render(conn, "show.json", table_row: table_row)
      {:error, changeset} ->
        conn
        |> put_status(:unprocessable_entity)
        |> render(Whitepages2.ChangesetView, "error.json", changeset: changeset)
    end
  end

  def delete(conn, %{"id" => id, "organization_id" => organization_id}) do
    table_row = Apartmentex.get!(Repo, TableRow, id, organization_id)

    # Here we use delete! (with a bang) because we expect
    # it to always work (and if it does not, it will raise).
    Repo.delete!(table_row)

    send_resp(conn, :no_content, "")
  end
end
