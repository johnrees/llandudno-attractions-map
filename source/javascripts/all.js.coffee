# http://maps.googleapis.com/maps/api/geocode/json?sensor=false&address=llwynon%20road%20llandudno

window.markers = []

buildMap = ->

  mapOptions =
    mapTypeId: google.maps.MapTypeId.ROADMAP

  map = new google.maps.Map(
    document.getElementById('map'),mapOptions)

  latlngbounds = new google.maps.LatLngBounds()

  $('li a').each ->

    latlng = new google.maps.LatLng($(this).data('lat'), $(this).data('lng'))
    latlngbounds.extend latlng

    marker = new google.maps.Marker
      position: latlng
      map: map
      url: $(this).attr('href')
      icon: 'http://maps.google.com/mapfiles/ms/icons/red-dot.png'

    window.markers.push marker

    google.maps.event.addListener marker, 'click', ->
      window.location = marker.url

    google.maps.event.addListener marker, 'mouseover', ->
      $("li a[href='#{marker.url}']").addClass('active')
      marker.setIcon('http://maps.google.com/mapfiles/ms/icons/yellow-dot.png')

    google.maps.event.addListener marker, 'mouseout', ->
      $("li a[href='#{marker.url}']").removeClass('active')
      marker.setIcon('http://maps.google.com/mapfiles/ms/icons/red-dot.png')

  map.setCenter(latlngbounds.getCenter())
  map.fitBounds(latlngbounds)

  $('li a').mouseenter ->
    map.setZoom(14)
    map.panTo(
      new google.maps.LatLng($(this).data('lat'), $(this).data('lng'))
    )
    index = $('li a').index(this)
    window.markers[index].setIcon('http://maps.google.com/mapfiles/ms/icons/yellow-dot.png')

  $('li a').mouseleave ->
    map.setCenter(latlngbounds.getCenter())
    map.fitBounds(latlngbounds)
    index = $('li a').index(this)
    window.markers[index].setIcon('http://maps.google.com/mapfiles/ms/icons/red-dot.png')

jQuery ->

  $(window).ready ->
    buildMap()
