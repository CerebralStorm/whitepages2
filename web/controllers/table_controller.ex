defmodule Whitepages2.TableController do
  use Whitepages2.Web, :controller

  alias Whitepages2.Table

  def index(conn, %{"organization_id" => organization_id}) do
    tables = Repo.all(Table)
    render(conn, "index.json", tables: tables, organization_id: organization_id)
  end

  def create(conn, %{"table" => table_params,  "organization_id" => organization_id}) do
    changeset = Table.changeset(%Table{}, table_params)

    case Apartmentex.insert(Repo, changeset, organization_id) do
      {:ok, table} ->
        conn
        |> put_status(:created)
        |> put_resp_header("location", organization_table_path(conn, :show, organization_id, table))
        |> render("show.json", table: table)
      {:error, changeset} ->
        conn
        |> put_status(:unprocessable_entity)
        |> render(Whitepages2.ChangesetView, "error.json", changeset: changeset)
    end
  end

  def show(conn, %{"id" => id,  "organization_id" => organization_id}) do
    table = Apartmentex.get!(Repo, Table, id, organization_id)
    render(conn, "show.json", table: table)
  end

  def update(conn, %{"id" => id, "table" => table_params,  "organization_id" => organization_id}) do
    table = Apartmentex.get!(Repo, Table, id, organization_id)
    changeset = Table.changeset(table, table_params)

    case Repo.update(changeset) do
      {:ok, table} ->
        render(conn, "show.json", table: table)
      {:error, changeset} ->
        conn
        |> put_status(:unprocessable_entity)
        |> render(Whitepages2.ChangesetView, "error.json", changeset: changeset)
    end
  end

  def delete(conn, %{"id" => id, "organization_id" => organization_id}) do
    table = Apartmentex.get!(Repo, Table, id, organization_id)

    # Here we use delete! (with a bang) because we expect
    # it to always work (and if it does not, it will raise).
    Repo.delete!(table)

    send_resp(conn, :no_content, "")
  end
end
