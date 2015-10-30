var fs = require('fs');
var fileActions = require('./fileactions.js')

fs.readFile("./episodes.json", 'utf8', fileActions);
