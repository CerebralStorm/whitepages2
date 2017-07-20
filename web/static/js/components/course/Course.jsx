import React from "react"
import ReactDOM from "react-dom"
import Dashboard from './Dashboard'
import StudentInfo from './StudentInfo'
import Messages from './Messages'

import {
  BrowserRouter as Router,
  Route,
  Link,
  Redirect
} from 'react-router-dom'

class Course extends React.Component {
  render() {
    return(
      <Router>
        <div>
          <ul className="nav nav-tabs">
            <li><Link to="/dashboard">Dashboard</Link></li>
            <li><Link to="/student_info">Student Info</Link></li>
            <li><Link to="/messages">Messages</Link></li>
          </ul>

          <Redirect from="/" exact to="/dashboard" />
          <Route path="/dashboard" component={Dashboard}/>
          <Route path="/student_info" component={StudentInfo}/>
          <Route path="/messages" component={Messages}/>
        </div>
      </Router>
    )
  }
}

export default Course;