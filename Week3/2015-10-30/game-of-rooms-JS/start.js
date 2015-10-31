var read = require('read');
var fs = require('fs');
var filePath = './savefile.json';
var Game = require('./Game');
var gamedata = require('./gamedata');

function newGame(name) {
    var rooms = gamedata;
    aGame = new Game(rooms, 'Dark room', { 'name': 'Ondrej', 'inv': []});
    aGame.playGame();
}

function loadGame() {
    var gamedata = JSON.parse(fs.readFileSync(filePath).toString());
    aGame = new Game(gamedata['rooms'], gamedata['selection'], gamedata['player']);
    aGame.playGame();
}

function pickGame(err, input) {

    if (input === "1") {
        newGame();
    } else if (input === "2") {
        loadGame();
    } else {
        return;
    }
}

console.log("Game of Rooms - JS style");
console.log("1. New game");
console.log("2. Load game");

var options = {
    prompt: "> "
}
read(options, pickGame)
