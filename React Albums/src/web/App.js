import React from 'react';
import { connect } from 'react-redux'

import AlbumList from './AlbumList.js'
import Login from './Login.js'
import Register from './Register.js'

class App extends React.Component {
//Bestemmer hvilken component som skal vises frem
//State / Redux!

    constructor(props) {
        super(props);
        this.logout = this.logout.bind(this);
        this.login = this.login.bind(this);
        this.register = this.register.bind(this);
    }



    login(username, password) {
        console.log('login called with', username, password);
        // send brukernavn og passord til serveren

        fetch('/login', {
            method: 'post',
            headers: {
               'Content-Type': 'application/json'
            },
            body: JSON.stringify({
                username,
                password
            })
        })
            .then(res => res.text())
            .then(token => this.setState({token}))
            .catch(err => console.log('error: ' + err));
    }

    register(username, password) {
        // opprett en ny bruker
        // lagre token
        // skriv den nye brukeren til state

        const user = {
            username,
            password
        };

        this.props.setUser(user);
    }

    logout(){
        this.props.setUser(undefined)
    }

    render() {
        const {
            user
        } = this.props;

        if (!user) {
            // return default page + login/register form
            return <div className="container">
                <Login onLogin={this.login}/>
                <hr/>
                <Register onRegister=
                              {(username, password) => this.register(username, password)} />
                <hr/>
                <AlbumList albums={this.props.albums}/>
            </div>
        } else {
            // return data for logged in user
            return <div className="container">
                <p>Hello, {JSON.stringify(user)}!</p>
                <button className="btn btn-danger" onClick=
                    {this.logout}> Log out</button>
                <hr/>
                <AlbumList albums={this.props.albums} />
            </div>
        }
    }

    //https://matoski.com/article/jwt-express-node-mongoose/#jwt
    //https://hackhands.com/mongodb-crud-mvc-way-with-passport-authentication/
}

function mapStateToProps(state) {
    console.log(state);
    return {
        user: state.user
    };
}

function mapDispatchToProps(dispatch) {
    return {
        setUser: (user) => dispatch({
            type: 'SET_USER',
            data: user
        }),
        logout: () => dispatch({
            type: 'LOGOUT',
            data: undefined
        })
    };
}

const ConnectedApps = connect(
    mapStateToProps,
    mapDispatchToProps
)(App);

export default ConnectedApps;