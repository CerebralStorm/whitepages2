defmodule Whitepages2.TableColumnController do
  use Whitepages2.Web, :controller

  alias Whitepages2.TableColumn

  def index(conn, %{"organization_id" => organization_id}) do
    table_columns = Apartmentex.all(Repo, TableColumn, organization_id)
    render(conn, "index.json", table_columns: table_columns)
  end

  def create(conn, %{"table_column" => table_column_params, "organization_id" => organization_id,  "table_id" => table_id}) do
    changeset = TableColumn.changeset(%TableColumn{}, table_column_params)

    case Apartmentex.insert(Repo, changeset, organization_id) do
      {:ok, table_column} ->
        conn
        |> put_status(:created)
        |> put_resp_header("location", organization_table_table_column_path(conn, :show, table_column, organization_id, table_id))
        |> render("show.json", table_column: table_column)
      {:error, changeset} ->
        conn
        |> put_status(:unprocessable_entity)
        |> render(Whitepages2.ChangesetView, "error.json", changeset: changeset)
    end
  end

  def show(conn, %{"id" => id, "organization_id" => organization_id}) do
    table_column = Apartmentex.get!(Repo, TableColumn, id, organization_id)
    render(conn, "show.json", table_column: table_column)
  end

  def update(conn, %{"id" => id, "table_column" => table_column_params, "organization_id" => organization_id}) do
    table_column = Apartmentex.get!(Repo, TableColumn, id, organization_id)
    changeset = TableColumn.changeset(table_column, table_column_params)

    case Repo.update(changeset) do
      {:ok, table_column} ->
        render(conn, "show.json", table_column: table_column)
      {:error, changeset} ->
        conn
        |> put_status(:unprocessable_entity)
        |> render(Whitepages2.ChangesetView, "error.json", changeset: changeset)
    end
  end

  def delete(conn, %{"id" => id, "organization_id" => organization_id}) do
    table_column = Apartmentex.get!(Repo, TableColumn, id, organization_id)

    # Here we use delete! (with a bang) because we expect
    # it to always work (and if it does not, it will raise).
    Repo.delete!(table_column)

    send_resp(conn, :no_content, "")
  end
end
