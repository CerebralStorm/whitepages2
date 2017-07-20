defmodule Whitepages2.TableRowView do
  use Whitepages2.Web, :view

  def render("index.json", %{table_rows: table_rows}) do
    %{data: render_many(table_rows, Whitepages2.TableRowView, "table_row.json")}
  end

  def render("show.json", %{table_row: table_row}) do
    %{data: render_one(table_row, Whitepages2.TableRowView, "table_row.json")}
  end

  def render("table_row.json", %{table_row: table_row}) do
    %{id: table_row.id,
      table_id: table_row.table_id,
      data: table_row.data}
  end
end
