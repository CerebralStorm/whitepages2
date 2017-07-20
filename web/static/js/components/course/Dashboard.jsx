import React from "react"
import ReactDOM from "react-dom"
import DashboardTable from "./DashboardTable"
import $ from "jquery"

class Dashboard extends React.Component {
  constructor(props) {
    super(props);

    this.state = {
      tables: []
    };

    $.ajax({
      url: '/api/organizations/1/tables',
      type: 'GET',
      success: (response) => {
        this.setState({ tables: response.data })
      }
    });
  }

  render() {
    let tables = this.state.tables.map(table => (
      <DashboardTable key={table.id} table={table} />
    ))

    return(
      <div>
        <h1>Dashboard</h1>
        {tables}
      </div>
    )
  }
}

export default Dashboard;