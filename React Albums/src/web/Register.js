import React from 'react'

export default class Register extends React.Component {
    render() {
        return (
            <div>
                <h1>Register</h1>
                <form action="#" className="form"
                      onSubmit={() => this.props.onRegister(
                            document.getElementById('username-register').value,
                            document.getElementById('password-register').value
                        )}>
                    <input id="username-register"
                           type="text"
                           placeholder="username"
                           className="form-control"
                    />
                    <input id="password-register" type="text" placeholder="password" className="form-control"/>
                    <button className="btn btn-primary"> Register </button>
                </form>
            </div>
        )
    }
}