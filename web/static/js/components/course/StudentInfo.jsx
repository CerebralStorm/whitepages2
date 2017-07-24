import React from "react"
import ReactDOM from "react-dom"
import $ from "jquery"
import { Link } from 'react-router-dom'

class StudentInfo extends React.Component {
  constructor(props) {
    super(props);

    this.state = {
      users: []
    };

    $.ajax({
      url: '/api/organizations/1/users',
      type: 'GET',
      success: (response) => {
        this.setState({ users: response.data })
      }
    });
  }
  render() {
    let users = this.state.users.map(user => (
      <li key={user.id}><Link to={"/users/" + user.id}>{user.sis_id}</Link></li>
    ))

    return(
      <div>
        <h1>Student Info</h1>
        <ul className="nav nav-pills nav-stacked">
          {users}
        </ul>
      </div>
    )
  }
}

export default StudentInfo;