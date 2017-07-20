import React from "react"
import ReactDOM from "react-dom"
import $ from "jquery"

class DashboardTableRow extends React.Component {
  constructor(props) {
    super(props);
  }

  render() {
    let cells = this.props.columns.map(column => (
      <td key={column.id}>{this.props.row.data[column.name]}</td>
    ))

    return(
      <tr>
        {cells}
      </tr>
    )
  }
}

export default DashboardTableRow;