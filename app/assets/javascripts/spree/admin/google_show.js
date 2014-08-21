

$( document ).ready(function() {

var defaultZoom = 17; // Why zoomed in? Because it looks good.

  var lat = <%= @location.lat %>;
  var lng = <%= @location.lng %>;

  // create map and add controls
  var mapOptions = {
    center: new google.maps.LatLng(lat, lng),
    zoom: defaultZoom,
    mapTypeId: google.maps.MapTypeId.ROADMAP,
    scrollwheel: true,
    scaleControl: true
  };
  var map = new google.maps.Map(document.getElementById('map'),mapOptions);

  // Im Centering the map in Bangkok
  // '13.731547730050778'
  // '100.56798934936523'
  var mylat = document.getElementById("location_lat").value;
  var mylng = document.getElementById("location_lng").value;
  if (jQuery.isEmptyObject(mylat)) {
    var mylat = lat;
    var mylng = lng;
  };

  // set center point of map to be of the Marker or the Default City
  var centrePoint = new google.maps.LatLng(mylat, mylng);

  map.setCenter(centrePoint);
  map.setZoom(defaultZoom);

  // add a draggable marker
  marker = new google.maps.Marker({
    map:map,
    draggable: false,
    animation: google.maps.Animation.DROP,
    position: centrePoint
  });

  // Set marker image
  var defaultImage = new google.maps.MarkerImage(
      "http://maps.gstatic.com/mapfiles/place_api/icons/geocode-71.png",
      new google.maps.Size(71, 71),
      new google.maps.Point(0, 0),
      new google.maps.Point(17, 34),
      new google.maps.Size(35, 35)
  );
  marker.setIcon(defaultImage);

});

