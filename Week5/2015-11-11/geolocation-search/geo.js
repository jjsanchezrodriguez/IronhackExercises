'use strict'

var geo;
var watchId;
var map = {
    apiKey : "&key=AIzaSyBmhV2TynprYY-Dz9lI2V2UXcI5nl7IUnA",
    baseURL : "https://maps.googleapis.com/maps/api/staticmap?&zoom=17",
    latitude: null,
    longitude: null,
    center: null,
    markers: null,
    size: "&size=800x600",
    genCenter: function() {
        this.center = "&center=" + this.latitude + ',' + this.longitude;
    },
    genMarkers: function() {
        this.markers = "&markers=color:blue%7Clabel:S%7C" + this.latitude + ',' + this.longitude
    },
    URL: function() {
        this.genCenter();
        this.genMarkers();
        return this.baseURL + this.size + this.center + this.markers + this.apiKey;
    }
}

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
    map.center = null;
    map.latitude = position.coords.latitude;
    map.longitude = position.coords.longitude;
    $('div.load').empty();
    $('div.location').empty();
    var posLabel = $('<p>').text("Latitude: " + map.latitude + " Longitude: " + map.longitude);
    $('div.location').append(posLabel);
    var img = $('<img>');
    img.attr('src', map.URL() );
    $('div.location').append(img);
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

