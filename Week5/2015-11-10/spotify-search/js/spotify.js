$(document).ready(function() {

    // selectors used often
    var results = $('ul#results');
    var input = $('input[type=text]');

    // default when page loaded
    $(results).hide();

    var query = {
        term: "",
        artistURL: function() {
            return "https://api.spotify.com/v1/search?type=artist&query=" + this.term;
        },
        albumURL: function() {
            return "https://api.spotify.com/v1/artists/" + this.term + "/albums";
        },
        albumTracksURL:  function() {
            return "https://api.spotify.com/v1/albums/" + this.term + "/tracks";
        }
    }


    function requestArtistAlbums() {
        $.ajax({
            url: query.albumURL(),
            success: handleArtistAlbums,
            error: handleError,
            dataType: 'json'
        })
    }

    function requestArtistDetails() {
        $.ajax({
            url: query.artistURL(),
            success: handleArtistDetails,
            error: handleError,
            dataType: 'json'
        })
    }

    function requestAlbumTracks() {
        $.ajax({
            url: query.albumTracksURL(),
            success: handleAlbumTracks,
            error: handleError,
            dataType: 'json'
        })
    }

    function handleAlbumTracks(response) {
        $("div.album-tracks[id=" + query.term + "]").empty();
        response.items.forEach(function(item) {
            var trackLink = $("<a></a>").attr({
                href: item.preview_url,
                target: '_blank'
            });
            var trackTitle = $("<p></p>").addClass('track').text(item.track_number + '  ' + item.name)
            $("div.album-tracks[id=" + query.term + "]").append(trackLink.append(trackTitle));
        });
    }

    function handleArtistAlbums(response) {
        $('.modal-body').empty();
        response.items.forEach(function(item) {
            var albumDiv = $("<div></div>").addClass('album')
            var albumName = $("<h1></h1>").addClass('album-name').text(item.name);
            var albumImage = $("<img></img>").addClass('album-art').attr('src', item.images[0].url).attr('data', item.id);
            var albumTracks = $("<div></div>").addClass('album-tracks').attr('id', item.id);
            $(albumDiv).append(albumName, albumImage, albumTracks);
            $('.modal-body').append(albumDiv);
        });
    }

    function handleArtistDetails(response) {
        $(results).empty();
        response.artists.items.forEach(function(item) {
            var li = $("<li></li>").addClass('list-group-item').text(item.name);
            if (item.images.length > 0) {
                var image = $("<img></img>").addClass('spotify-avatar')
                    .attr({data: item.id,
                        src: item.images[0].url,
                        'data-target': '#myModal',
                        'data-toggle': 'modal'
                    });
                li.prepend(image);
            }
            $(results).append(li);
        });
        $(results).show();
    }

    function handleError(jqXHR, status, errorThrown) {
        alert('Something went wrong.')
    }

    // prevent post on form
    $('form').on('submit', function(event) {
        event.preventDefault();
        $(input).val('');
        console.log(query.term);
    });

    // search button animation & trigger
    $('button[type=submit]').click(function() {
        $(this).fadeOut(100).fadeIn(100).fadeOut(100).fadeIn(200);
        query.term = $(input).val();
        requestArtistDetails();
    });

    // listen for uncreated elements
    $('body').on('click', 'img.spotify-avatar', function(event) {
        $('h4.modal-title').text($(event.target).parent().text());
        query.term = $(event.target).attr('data');
        requestArtistAlbums();
    });

    // listen for uncreated elements
    $('body').on('click', 'img.album-art', function(event) {
        query.term = $(event.target).attr('data');
        requestAlbumTracks();

        $("div.album-tracks[id=" + query.term + "]").slideToggle() 
    });

});
