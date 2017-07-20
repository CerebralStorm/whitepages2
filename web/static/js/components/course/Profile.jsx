import React from "react"
import ReactDOM from "react-dom"
import $ from "jquery"

class Profile extends React.Component {
  constructor(props) {
    super(props);

    this.state = {
      user: {}
    };

    $.ajax({
      url: '/api/organizations/1/users/' + props.match.params.user_id,
      type: 'GET',
      success: (response) => {
        this.setState({ user: response.data })
      }
    });
  }

  render() {
    let userFields
    if (this.state.user && this.state.user.data) {
      userFields = Object.entries(this.state.user.data).map(item =>(
        <div key={item[0]}>{item[0]}: {item[1]}</div>
      ))
    }

    return(
      <div>
        <h1>Profile</h1>
        <div>{this.state.user.canvas_user_id}</div>
        <div>{this.state.user.sis_id}</div>
        {userFields}
      </div>
    )
  }
}

export default Profile;