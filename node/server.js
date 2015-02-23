// Startup Express App
var express = require('express');
var app = express();

var http = require('http').Server(app);
var io = require('socket.io')(http);
http.listen(process.env.PORT || 3000);

// Configure Redis client connection
var redis = require('redis');
var credentials;
// Check if we are in Bluemix or localhost
if(process.env.VCAP_SERVICES) {
    // On Bluemix read connection settings from
    // VCAP_SERVICES environment variable
    var env = JSON.parse(process.env.VCAP_SERVICES);
    credentials = env['redis-2.6'][0]['credentials'];
} else {
    // On localhost just hardcode the connection details
    credentials = { "host": "127.0.0.1", "port": 6379 }
}
// Connect to Redis
var redisClient = redis.createClient(credentials.port, credentials.host);
if('password' in credentials) {
    // On we need to authenticate against Redis
    redisClient.auth(credentials.password);
}



// Configure Jade template engine
var path = require('path');
app.set('views', path.join(__dirname, 'views'));
app.set('view engine', 'jade');
app.use(express.static(path.join(__dirname, 'public')));

// handle HTTP GET request to the "/" URL​
app.get('/', function(req, res) {
//    res.render('index'); 
    // Get the 100 most recent messages from Redis​
    var messages = redisClient.lrange('messages', 0, 99, function(err, reply) {
        if(!err) {
            var result = [];
            // Loop through the list, parsing each item into an object
            for(var msg in reply) result.push(JSON.parse(reply[msg]));
            // Pass the message list to the view
            res.render('index', { messages: result });
        } else res.render('index');
    }); 
});



// socket.io listen for messages​
io.on('connection', function(socket) { 
    // When a message is received, broadcast it
    // to all users except the originating client
    socket.on('msg', function(data) {
        socket.broadcast.emit('msg', data);
// 無名関数？
	redisClient.lpush('messages', JSON.stringify(data));
	redisClient.ltrim('messages', 0, 99);
    });
   
    // When a user joins the chat, send a notice​
    // to all users except the originating client
    socket.on('join', function(nickname) {
        // Attach the user's nickname to the socket
        socket.nickname = nickname;
        socket.broadcast.emit('notice', nickname + ' has joined the chat.');
    });

      // When a user disconnects, send a notice
    // to all users except the originating client
    socket.on('disconnect', function() {
        socket.broadcast.emit('notice', socket.nickname + ' has left the chat.');
    });
});
