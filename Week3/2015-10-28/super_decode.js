var decode = require("./decode.js");

function superDecode(sentence, optionsStr) {
    sentence = sentence.split(' ');
    optionsStr = optionsStr.split('-');

    var options = {
        forward: false,
        oddWords: false,
        allWords: false
    }

    // String parser (optionsStr)
    switch (optionsStr[0]) {
        case 'odd':
            options['oddWords'] = true;
            break;
        case 'even':
            options['oddWords'] = false;
            break;
        case 'all':
            options['allWords'] = true;
    }

    switch (optionsStr[1]) {
        case 'backwards':
            options['forward'] = false;
            break;
        case 'forward':
            options['forward'] = true;
    }


    console.log("Sentence: " + sentence);
    console.log("Options: " + "Forward? " + options['forward']
            + "All words? " + options['allWords']
            + "Even words? " + options['oddWords']);

    // Select odd or even words
    if (!(options['allWords'])) {
        sentence = sentence.filter(function(item, index) {
            if (options['oddWords']) {
                if (index % 2 === 0) {
                    return item;
                }
            } else {
                if (index % 2 != 0) {
                    return item;
                }
            }
        })
    }

    
    // Go forward or backwards
    if (!(options['forward'])) {
        sentence.reverse();
    }

    console.log("Filtered words: " + sentence);
   return decode(sentence);
}



//var sentence = "fill the proper tank for the cow";
//var message = superDecode(sentence, 'odd-backwards');
//console.log("Decoded message: " + message);

var sentence1 = "Attack her nose under here with an itch";
var message1 = superDecode(sentence1, 'all-backwards');

var sentence2 = "Raul Nuñez call never finished"
var message2 = superDecode(sentence2, 'all-forward');

var sentence3 = "Start rapping this or countless queasy wizards give back jay-z"
var message3 = superDecode(sentence3, 'all-backwards');

var sentence4 = "inner peace is overrated"
var message4 = superDecode(sentence4, 'odd-forward');

var sentence5 = "Fill the proper tank for the cow"
var message5 = superDecode(sentence5, 'odd-backwards');

var messages = [
    message1, message2, message3, message4, message5
];

console.log("\nSecrets:")
messages.forEach(function(message) {console.log(message)});
