import express from 'express';
const app = express();
const http = require('http').createServer(app);
const io = require('socket.io')(http);

const host = '127.0.0.1';
const port = 7000;

let clients = [];

io.on('connection', (socket) => {
    console.log(`Client with id ${socket.id} connected`);
    clients.push(socket.id);

    socket.emit('message', "I'm server");

    socket.on('message', (message) =>
        console.log('Message: ', message)
    );

    socket.on('disconnect', () => {
        clients.splice(clients.indexOf(socket.id), 1);
        console.log(
            `Client with id ${socket.id} disconnected`
        );
    });
});