import React from "react"
import ReactDOM from "react-dom"
import { Link } from 'react-router-dom'
import $ from "jquery"
import Alert from 'react-bootstrap/lib/Alert';

class EditStudentInfo extends React.Component {
  constructor(props) {
    super(props);
    this.state = {
      user: {},
      alertSuccess: false,
      alertFailure: false
    };

    $.ajax({
      url: '/api/organizations/1/users/' + props.match.params.user_id,
      type: 'GET',
      success: (response) => {
        this.setState({user: response.data})
      }
    });
    this.handleChange = this.handleChange.bind(this);
    this.handleSubmit = this.handleSubmit.bind(this);
    this.handleAlertDismiss = this.handleAlertDismiss.bind(this);
  }

  handleChange(event) {
    let user = this.state.user
    user.data[event.target.name] = event.target.value
    this.setState({user: user})
  }

  handleSubmit(event) {
    event.preventDefault()
    $.ajax({
      url: '/api/organizations/1/users/' + this.props.match.params.user_id,
      type: 'PUT',
      data: {user: this.state.user},
      success: (response) => {
        console.log(response)
        this.setState({alertSuccess: true})
      },
      error: (response) => {
        this.setState({alertFailure: true})
        console.log(response)
      }
    });
  }

  handleAlertDismiss() {
    this.setState({alertSuccess: false, alertFailure: false})
  }
  render() {
    let userFormFields
    if (this.state.user && this.state.user.data) {
       userFormFields = Object.entries(this.state.user.data).map(item =>(
        <div className="form-group" key={item[0]}>
          <label htmlFor={item[0]}>{item[0]}</label>
          <input type="text" name={item[0]} value={item[1]} onChange={this.handleChange} className='form-control' />
        </div>
      ))
    }
    return(
      <form onSubmit={this.handleSubmit}>
        {this.state.alertSuccess && <Alert bsStyle="success" onDismiss={this.handleAlertDismiss}>
          <p>User Saved!</p>
        </Alert>}
        {this.state.alertFailure && <Alert bsStyle="danger" onDismiss={this.handleAlertDismiss}>
          <h4>An error occured while trying to save!</h4>
          <p>please check your settings and try again.</p>
        </Alert>}
        {userFormFields}
        <button type="submit" className="btn btn-default">Save</button>
      </form>
    )
  }
}

export default EditStudentInfo;