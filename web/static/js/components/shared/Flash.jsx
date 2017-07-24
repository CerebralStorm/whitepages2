import React from "react"
import ReactDOM from "react-dom"

class Flash extends React.Component {
  constructor(props) {
    super(props);

    this.state = {
      message: props.message,
      showFlash: (props.message.length > 0),
    };

    this.removeAlert = this.removeAlert.bind(this);
    setTimeout(this.removeAlert, 5000)
  }

  removeAlert() {
    this.setState({showFlash: false})
  }

  render() {
    console.log('renderFlash')
    if (!this.state.showFlash) {
      return null;
    }

    setTimeout(this.removeAlert, 5000)

    return(
      <div className={this.props.classNames} role="alert">
        <button onClick={this.removeAlert} type="button" className="close" data-dismiss="alert" aria-label="Close">
          <span aria-hidden="true">&times;</span>
        </button>
        {this.state.message}
      </div>
    )
  }
}

export default Flash;