var phrases = {
    list: [
    "Hello", "JavaScript", "Whatever", "Crap",
    "What ya looking at?", "Blabla"
    ]
} 
$(document).on('ready', function() {

    var phrasesParagraph = $('p.phrases');
    var hideShowLink = $('#toggle-phrases');

    function getRandomPhrase() {
        return phrases.list[Math.floor(Math.random() * phrases.list.length)];
    }

    function togglePhrasesList() {
        phrasesParagraph.text('');
        phrases.list.forEach(function(ph) {
            phrasesParagraph.append("<p class='item'>" + "<a class='delete-phrase' href='#'>X</a>" + ph + "</p>" );
        });

    }

    function togglePhraseLink() {
        if (hideShowLink.text() === 'Show phrases') {
            hideShowLink.text('Hide phrases');
        } else {
            hideShowLink.text('Show phrases');
        }
    }

    function deletePhrase(text) {
        for(var i = 0; i < phrases.list.length; i++) {
            if(phrases.list[i] === text) {
                phrases.list.splice(i, 1);
            } 
        }
        if(phrases.list.length < 1) {
            $('h1.phrase').text('')
        }
    }

    function colorizeCurrent() {
        $('p.item').css('color','black');
      $('p.item').each(function() {
            var str = ($(this).text().substring(1));
            if (str === $('h1.phrase').text()) {
                $(this).css('color', 'red');
            }
        }) 
    }

    $('p.phrases').hide();

    $('h1.phrase').text(getRandomPhrase())

    $('#phrase-button').on('click', function() {
        $('h1.phrase').text(getRandomPhrase());
        colorizeCurrent();
    });

    $('form').on('submit', function(event) {
        event.preventDefault();
        var input = $('input');
        phrases.list.push(input.val());
        input.val('');
    });

    $('#toggle-phrases').on('click', function(event) {
        event.preventDefault();
        togglePhraseLink();
        togglePhrasesList();
        phrasesParagraph.toggle();
        colorizeCurrent();

    });

    $('body').on( 'click', 'a.delete-phrase',function(event) {
        event.preventDefault();
        var text = $(this).parent().text().substring(1);
        deletePhrase(text);
        $(this).parent().remove();
    })
})
