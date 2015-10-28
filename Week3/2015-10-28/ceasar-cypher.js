// ITERATION 4
//
// ASCII capital letters: 65 - 90
// ASCII lowercase letters: 97 - 122

function caesarCipher(message, shift) {

    shift === undefined ? shift = -3 : shift;

    function isNotWhitespace(l) {
        if (l.indexOf(" ") >= 0) {
            return false;
        } else {
            return true;
        }
    }

    function isAlpha(l) {
        if (l.match(/[a-z]/) != null) {
            return true;
        } else {
            return false;
        }
    }

    function isCapitalAlpha(l) {
        if (l.match(/[A-Z]/) != null) {
            return true;
        } else {
            return false;
        }
    }

    function shiftWithinBounds(letter, shift) {
        var letterCode = letter.charCodeAt(0);
        if (isAlpha(letter)) {
            if (letterCode + shift > 122) {
                return 96 + ((letterCode + shift) % 122);
            } else if (letterCode + shift < 97) {
                return 122 - (97 % (letterCode + shift));
            } else {
                return letterCode + shift
            }
        } else {
            if (letterCode + shift > 90) {
                return 65 + ((letterCode + shift) % 90);
            } else if (letterCode + shift < 65) {
                return 90 - (65 % (letterCode + shift));
            } else {
                return letterCode + shift
            }
        }
    }

    message = message.split('').map(function(letter) {
        if (isNotWhitespace(letter) && isAlpha(letter) || isCapitalAlpha(letter)) {
            var encrypted_num = shiftWithinBounds(letter, shift);
            return String.fromCharCode(encrypted_num);
        } else {
            return letter;
        }
    }).join('');

    return message;
}

var original = "Et tu, brute?"
var encrypted1 = caesarCipher(original, 6);
// using default arguments (shift of -3)
var encrypted2 = caesarCipher(original);

console.log("Original message: " + original);
console.log("Encrypted message => " + encrypted1);
console.log("Algorhitm succesful? ", encrypted1 === "Kz za, hxazk?");
console.log("\n");
console.log("Original message: " + original);
console.log("Encrypted message => " + encrypted2);
console.log("Algorhitm succesful? ", encrypted2 === "Bq qr, xorqb?");
