function decode(words) {
    return words.map(function(word, index) {
        if (index >= 5) {
            return word[index % 5];
        } else {
            return word[index];
        }
    }).join('');
}

module.exports = decode;
