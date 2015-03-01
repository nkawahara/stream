$(document).ready(function() {
/*
    var socket = io(), nickname, textList = $('#messages');
    // Check if nickname stored in localStorage
    if('localStorage' in window && localStorage.getItem('nickname')) {
	nickname = localStorage.getItem('nickname');
    } else {
	// If not in localStorage, prompt user for nickname
	nickname = prompt('Please enter your nickname');
	if('localStorage' in window) {
	    localStorage.setItem('nickname', nickname);
	}
    }
    // Send message to server that user has joined
    socket.emit('join', nickname);
    // Function to add a message to the page
    var newMessage = function(data) {
	var who = $('<div class="who">').text(data.nickname),
	when = $('<div class="when">').text(new Date().toString().substr(0, 24)),
	text = $('<div class="text">').text(data.text),
	header = $('<div class="header clearfix">').append(who).append(when),
	li = $('<li>').append(header).append(text);
	textList.prepend(li);
    };
    // Handle the form to submit a new message
    $('form').submit(function(e) {
	var textField = $('#text'),
	data = { text: textField.val(), name: nickname, created_at: new Date() };
	e.preventDefault();
	// Send message to Socket.io server
	socket.emit('text', data);
	// Add message to the page
	newMessage(data);
	// Clear the message field
	textField.val('');
    });
    // When a message is received from the server
    // add it to the page using newMessage()
    socket.on('text', function(data) { newMessage(data); });
    // When a notice is received from the server
    // (user joins or disconnects), add it to the page
    socket.on('notice', function(text) {
	textList.prepend($('<div class="notice">').text(text));
    });
*/
});
