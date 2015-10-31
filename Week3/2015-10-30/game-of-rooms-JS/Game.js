"use strict";

var read = require('read');
var fs = require('fs');
var filePath = './savefile.json';

var Game = function(rooms, start, player) {
    this.rooms = rooms;
    this.selection = start;
    this.currentRoom = null;
    this.finishedGame = false;
    this.player = player;

    this.movementValidator = function(input) {
        if (input in this.currentRoom.exits) {
            this.selection = this.currentRoom.exits[input];
            return true;
        } else {
            return false;
        }
    };

    this.pickUpItem = function(input) {
        var anItem = input.split("pick up")[1].trim();
        var itemIndex = this.currentRoom.items.indexOf(anItem);
        if (itemIndex != -1) {
            this.player.inv.push(this.currentRoom.items.splice(itemIndex, 1)[0]);
            console.log("Picked up " + anItem);
        } else {
            console.log("No such item.");
        }
    };

    this.dropItem = function(input) {
        var anItem = input.split("drop")[1].trim();
        var itemIndex = this.player.inv.indexOf(anItem);
        if (itemIndex != -1) {
            this.currentRoom.items.push(this.player.inv.splice(itemIndex, 1)[0]);
            console.log("You dropped " + anItem);
        } else {
            console.log("You don't have that item.");
        }
    };

    this.printer = function() {
        console.log("Name: " + this.currentRoom.name);
        console.log(this.currentRoom.description);
         if (this.currentRoom.items.length > 0) {
             console.log("You see " + this.currentRoom.items.join(' and ') + '.');
         }
         console.log("Exits: " + Object.keys(this.currentRoom.exits));
    };

    this.makeMove = function(err, input) {
        if (this.movementValidator(input)) {
            this.getCurrentRoom(this.currentRoom.exits[input]);
            this.gamePrompt();
        } else if (input === undefined) {
            ;
        } else if (input.indexOf("quit") != -1 || input.indexOf("exit") != -1) {
            return;
        } else if (input.indexOf("pick up") != -1) {
            this.pickUpItem(input);
            this.gamePrompt();
        } else if (input.indexOf("drop") != -1) {
            this.dropItem(input);
            this.gamePrompt();
        } else if (input.indexOf("inv") != -1) {
            console.log(this.player.inv)
            this.gamePrompt();
        } else if (input.indexOf("save") != -1) {
            this.saveGame();
            this.gamePrompt();
        } else {
            console.log("Can't go there!");
            this.gamePrompt();
        }
    };
    
    this.getCurrentRoom = function(selected) {
        this.currentRoom = this.rooms.find(function(room) {
            if (room.name === selected) {
                return room
            }
        });
    };

    this.playGame = function() {
        this.gamePrompt();
    };

    this.getOptions = function() {
        var options = {
            prompt: ">",
        };
        return options;
    };

    this.gamePrompt = function() {
        this.getCurrentRoom(this.selection);
        this.printer();
        if (this.currentRoom.name === 'Death') {
            return;
        }
        this.makeMove();

        read(this.getOptions(), this.makeMove.bind(this))
    }

    this.saveGame = function() {
        console.log(this.selection);
        var saveData = {
            'rooms': this.rooms,
            'selection': this.selection,
            'player': this.player
        };

        fs.writeFile(filePath, JSON.stringify(saveData), function(err) {
            if(err) {
                return console.log('Unable to write file ' + err);
            } else {
                console.log('File was saved');
            }
        });
    }
}

module.exports = Game;
