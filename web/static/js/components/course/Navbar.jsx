import React from "react"
import ReactDOM from "react-dom"

var Navbar = React.createClass({
  render() {
    return(
      <ul className="nav nav-tabs">
        <li role="presentation" className="active"><a href="#">Dashboard</a></li>
        <li role="presentation"><a href="#">Student Info</a></li>
        <li role="presentation"><a href="#">Messages</a></li>
      </ul>
    )
  }
})

export default Navbar;