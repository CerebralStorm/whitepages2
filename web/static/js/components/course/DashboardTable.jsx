import React from "react"
import ReactDOM from "react-dom"
import DashboardTableRow from "./DashboardTableRow"
import $ from "jquery"

class DashboardTable extends React.Component {
  constructor(props) {
    super(props);
  }

  render() {
    let columns = this.props.table.columns.map(column => (
      <th key={column.id}>{column.name}</th>
    ))

    let rows = this.props.table.rows.map(row => (
      <DashboardTableRow key={row.id} row={row} columns={this.props.table.columns} />
    ))

    return(
      <div>
        <h1>{this.props.name}</h1>
        <table className="table table-bordered">
          <thead>
            <tr>
              {columns}
            </tr>
          </thead>
          <tbody>
            {rows}
          </tbody>
        </table>
      </div>
    )
  }
}

export default DashboardTable;