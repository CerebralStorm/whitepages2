defmodule Whitepages2.TableColumnView do
  use Whitepages2.Web, :view

  def render("index.json", %{table_columns: table_columns}) do
    %{data: render_many(table_columns, Whitepages2.TableColumnView, "table_column.json")}
  end

  def render("show.json", %{table_column: table_column}) do
    %{data: render_one(table_column, Whitepages2.TableColumnView, "table_column.json")}
  end

  def render("table_column.json", %{table_column: table_column}) do
    %{id: table_column.id,
      table_id: table_column.table_id,
      name: table_column.name,
      position: table_column.position}
  end
end
