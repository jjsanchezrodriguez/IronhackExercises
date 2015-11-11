var map;
var infowindow;
var markers = [];

if ("geolocation" in navigator){
  navigator.geolocation.getCurrentPosition(onLocation, onError);
}

function reloadMarkers() {
    if (window.localStorage) {
        for (var location in window.localStorage) {
            var coords = window.localStorage[location].split(',');
            var position = {lat: parseFloat(coords[0]), lng: parseFloat(coords[1])};
            createMarker(position);
        }
    }
}

function addressLookUp(coords) {
    for (var location in window.localStorage) {
        if (coords === window.localStorage[location]) {
            return location;
        }
    }
}

function onLocation(position){
  // We can't just directly feed the position into our google map
  // The objects are formatted differently, google maps is looking for
  // an object with "lat" and "lng" keys.
  var myPosition = {
    lat: position.coords.latitude,
    lng: position.coords.longitude
  };

  createMap(myPosition);
}

function onError(err){
  console.log("What are you using, IE 7??", err);
}

function createMap(position){
  map = new google.maps.Map($('#map')[0], {
    center: position,
    zoom: 17
  });
  createMarker(position);
  reloadMarkers();
  setupAutocomplete();
}

function createMarker(position){
    var marker = new google.maps.Marker({
        position: position,
        map: map
    });
    marker.addListener('click', function(event){
        var lookUp = event.latLng.lat() + ',' + event.latLng.lng();
        var address = addressLookUp(lookUp);
        var aMarker = this;
        createInfoWindow(address, aMarker);
    });
    markers.push(marker)
}

function createInfoWindow(address, aMarker){
      var contentString = '<div id="content">'+
      '<div id="siteNotice">'+
      '</div>'+
      '<div id="bodyContent">'+
      address +
      '</div>'+
      '</div>';

      var infowindow = new google.maps.InfoWindow({
        content: contentString
      });
      infowindow.open(map, aMarker);

}

function setupAutocomplete(){
    var input = $('#get-places')[0];
    var autocomplete = new google.maps.places.Autocomplete(input);
    autocomplete.addListener('place_changed', function(){
        var place = autocomplete.getPlace();
        var coords = {
            lat: place.geometry.location.lat(), 
            lng: place.geometry.location.lng()
        };
        if (place.geometry.location) {
          map.setCenter(place.geometry.location);
          map.setZoom(17);
          createMarker(coords);
          window.localStorage.setItem(place.formatted_address, JSON.stringify(coords.lat) +',' +JSON.stringify(coords.lng));
          //window.localStorage
        } else {
          alert("The place has no location...?")
        }
    });
}

$('input#delete-places').click(function(){
    window.localStorage.clear();
    for (var i = 0; i < markers.length; i++) {
        markers[i].setMap(null);
    }
    markers = [];
});
