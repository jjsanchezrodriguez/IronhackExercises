'use strict'

var geo;
var watchId;

$('div.load').hide();

function requestPosition() {
    if (navigator.geolocation) {
        console.log('geo available');
        geo = navigator.geolocation;
        var options = {};
        geo.getCurrentPosition(onLocation, onError, options);
        $('div.load').show();
    } else {
        console.log('not available');
    }
}

function requestWatchPosition() {
        geo = navigator.geolocation;
        var options = {};
        watchId = geo.watchPosition(onLocation, onError, options);
        $('div.load').show();
}



function onLocation(position) {
    var c = position.coords;
    $('div.load').empty();
    $('div.location').empty();
    $('div.location').append("<p>Latitude: " + c.latitude + "</p><p>Longitude: " + c.longitude + "</p>");
}

function onError() {
    $('div.location').empty();
    $('div.location').append("<p>Error</p>");
}


$('.get-location').click(function() {
    requestPosition();
});

$('.get-watch').click(function() {
    $('div.location').empty();
    requestWatchPosition();
    $(this).hide();
    $('.stop-watch').show();
});

$('.stop-watch').hide(); 

$('.stop-watch').click(function() {
    geo.clearWatch(watchId);
    $(this).hide();
    $('div.location').empty();
    $('.get-watch').show();
});

