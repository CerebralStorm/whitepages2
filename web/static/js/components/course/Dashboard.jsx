import React from "react"
import ReactDOM from "react-dom"
import $ from "jquery"

class Dashboard extends React.Component {
  constructor(props) {
    super(props);

    this.state = {
      tables: []
    };

    $.ajax({
      url: '/api/organizations/1/tables/1',
      dataType: 'application/json',
      type: 'GET',
      done: (response) => {
        console.log("success")
        console.log(response['data'])
        this.state.tables = response['data']
      },
      error: (response) => {
        console.log("error")
        console.log(response)
      }
    });
  }

  render() {
    let tables = this.state.tables.map(table => (
      <div key={table.id} className='row'>
        <div className='col-md-3'>{table.name}</div>
      </div>
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