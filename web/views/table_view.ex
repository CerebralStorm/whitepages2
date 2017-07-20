defmodule Whitepages2.TableView do
  use Whitepages2.Web, :view

  def render("index.json", %{tables: tables}) do
    %{data: render_many(tables, Whitepages2.TableView, "table.json")}
  end

  def render("show.json", %{table: table}) do
    %{data: render_one(table, Whitepages2.TableView, "table.json")}
  end

  def render("table.json", %{table: table}) do
    %{id: table.id,
      user_id: table.user_id,
      course_id: table.course_id,
      name: table.name,
      columns: render_many(table.table_columns, Whitepages2.TableColumnView, "table_column.json"),
      rows: render_many(table.table_rows, Whitepages2.TableRowView, "table_row.json")
    }
  end
end
