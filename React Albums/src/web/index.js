import React from 'react';
import ReactDOM from 'react-dom';
import {Provider} from 'react-redux';
import {createStore} from 'redux';

import Reducer from './Reducer.js';
import App from './App.js';
import Login from './Login.js';


const container = document.getElementById('container');

const store = createStore(Reducer);

fetch('/albums', {
    headers: {
        'x-token': 'A TOKEN LOL so secret'
    }
})
    .then(res => res.json())
    .then(albums => {
        ReactDOM.render((
            <Provider store={store}>
                <App albums={albums} />
            </Provider>
        ),
            container
        );
    });