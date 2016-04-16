import React from 'react'

export default class Login extends React.Component {
    render() {
        return (
            <div>
                <h1>Login</h1>
                <form action="#" className="form"
                      onSubmit={() => this.props.onLogin(
                            document.getElementById('username-input').value,
                            document.getElementById('password-input').value
                        )}>
                    <input id="username-input"
                           type="text"
                           placeholder="username"
                           className="form-control"
                           />
                    <input id="password-input" type="text" placeholder="password" className="form-control"/>
                    <button className="btn btn-primary"> Login</button>
                </form>
            </div>
        )
    }
}