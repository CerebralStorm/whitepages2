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
    console.log(this.state.users)
    let users = this.state.users.map(user => (
      <Link key={user.id} to={"/users/" + user.id}>{user.sis_id}</Link>
    ))

    return(
      <div>
        <h1>Student Info</h1>
        {users}
      </div>
    )
  }
}

export default StudentInfo;