const router = require('express').Router();
const path = require('path');
const mongoose = require('mongoose');
const bodyParser = require('body-parser');
const jwt = require('jwt-simple');

router.use(bodyParser.json());

//Connect to database
mongoose.connect('mongodb://localhost/database');

//Create a db-model for Albums
const Album = mongoose.model('Album',{
    artist: String,
    title: String,
    year: String
});

//Create a db-model for Users
const User = mongoose.model('User', {
    username: String,
    password: String
});

//Get index-site and send the index.html file
router.get('/', (req, res) => res.sendFile(path.join(__dirname, '../../index.html')));

//Get /albums and send albums from the database
router.get('/albums', (req, res) => {
    // has a valid token?
    var token = req.header('x-token');
    const valid = token === 'A TOKEN LOL so secret';

    Album.find()
        .then(albums => {
            if (valid) {
                res.send(albums)
            } else {
                res.send(albums.slice(0, 10));
            }
        });
});

//Get login file and send the users from the database
router.get('/login', (req, res) => {
    User.find()
        .then(users => {
            res.send(users)
        })
});


router.post('/login', (req, res) => {
    const username = req.body.username;
    const password = req.body.password;

    // is username & password valid?
    const valid = username === 'blah' && password === 'bleh';
    if (valid) {
        return res.send('A TOKEN LOL so secret');
    } else {
        return res.status(401).send('wrong username or password');
    }
});

module.exports = router;