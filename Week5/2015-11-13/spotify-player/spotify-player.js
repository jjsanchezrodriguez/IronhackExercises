$(document).ready(function(){

    var songInfo = {
        artist: null,
        name: null,
        image: null,
        audio: null
    }

    var artistInfo = {
        name: null,
        genres: null,
        url: null,
        image: null
    }

    $('form').on('submit', function(event){
        event.preventDefault();
        var input = $('.search-form form input[type=text]');
        requestSong(input.val());
    });

    function simpleAjaxCall(url, success){
        $.ajax({
            url: url,
            success: success
        })
    }

    function requestSong(songName) {
        var url = "https://api.spotify.com/v1/search?type=track&limit=1&q=" + '"' + songName + '"';
        simpleAjaxCall(url, updatePlayer);
    }

    function resetPlayer(){
        $('div.seekbar progress').prop('value', 0);
        $('div.btn-play').removeClass('playing');
        $('div.btn-play').addClass('disabled');
    }

    function updatePlayer(response) {
        resetPlayer();
        songInfo.name = response.tracks.items[0].name;
        songInfo.artist = response.tracks.items[0].artists[0].name;
        $('.artist-info').prop('href', response.tracks.items[0].artists[0].href);
        songInfo.image = response.tracks.items[0].album.images[0].url;
        songInfo.audio = response.tracks.items[0].preview_url;
        $('div.metadata p.title').text(songInfo.name);
        $('div.metadata p,.author').text(songInfo.artist);
        $('div.cover img').prop('src', songInfo.image);
        $('audio').prop('src', songInfo.audio);
    }

    function fillModalTable(prop, val){
        var dt = $('<dt>').text(prop);
        var dd = $('<dd>').text(val);
        $('div.modal-body dl').append(dt, dd);
    }

    function updateModal(response){
        $('div.modal-body dl').empty();
        artistInfo.name = response.name;
        artistInfo.genres = response.genres.join(', '); 
        artistInfo.url = response.external_urls.spotify;
        artistInfo.image = response.images[0].url;
        $('div.modal-header h2').text(artistInfo.name);
        $('div.modal-header img').prop('src', artistInfo.image);
        fillModalTable("Genres", artistInfo.genres);
        fillModalTable("Spotify", artistInfo.url);

        $('.modal').modal();
    }

    $('div.btn-play').click(function(){
       if ($(this).hasClass('disabled')) {
            $('audio').trigger('play');
            $(this).removeClass('disabled');
            $(this).addClass('playing');
        } else {
            $('audio').trigger('pause');
            $(this).removeClass('playing');
            $(this).addClass('disabled');
        }
    });

    $('a.artist-info').click(function(event){
        event.preventDefault();
        simpleAjaxCall($(this).prop('href'), updateModal)
    });

    $('audio').on('timeupdate', function(){
        $('div.seekbar progress').prop('value', $(this).prop('currentTime'));
    });
})
