const express = require('express');
const mysql = require('mysql');

const bodyParser = require('body-parser');
const cookieParser = require('cookie-parser');
const port = 5000;
const connection = mysql.createConnection({
    host: 'localhost',
    user: 'root',
    password: '',
    database: '1bit'
});



const app = express();

app.use(cookieParser());
app.use(bodyParser.urlencoded({ extended: true }));

require('./app/routes')(app, connection)



app.listen(port, () => console.log('Сервер работает')) 