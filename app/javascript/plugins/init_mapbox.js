import mapboxgl from 'mapbox-gl';

const openInfoWindow = (markers) => {
  // Select all cards
  console.log(markers)
  const cards = document.querySelectorAll('.experience-card');
  cards.forEach((card, index) => {
    // Put a microphone on each card listening for a mouseenter event
    card.addEventListener('mouseenter', () => {
      // Here we trigger the display of the corresponding marker infoWindow with the "togglePopup" function provided by mapbox-gl
      markers[index].togglePopup();
    });
    // We also put a microphone listening for a mouseleave event to close the modal when user doesn't hover the card anymore
    card.addEventListener('mouseleave', () => {
      markers[index].togglePopup();
    });
  });
}

const toggleCardHighlighting = (event) => {
  // We select the card corresponding to the marker's id
  const card = document.querySelector(`[data-experience-id="${event.currentTarget.dataset.markerId}"]`);
  // Then we toggle the class "highlight github" to the card
  card.classList.toggle('highlight');
}

const fitMapToMarkers = (map, markers) => {
  const bounds = new mapboxgl.LngLatBounds();
  markers.forEach(marker => bounds.extend([ marker.lng, marker.lat ]));
  map.fitBounds(bounds, { padding: 70, maxZoom: 15, duration: 0 });
};

const initMapbox = () => {
  const mapElement = document.getElementById('index-map');


  if (mapElement) {
    // Build the map
    mapboxgl.accessToken = mapElement.dataset.mapboxApiKey;
    const map = new mapboxgl.Map({
      container: 'index-map',
      center: [2.3514992, 48.8566101],
      style: 'mapbox://styles/socksss/ck2tzd3ep4a8k1cryts4bpuqb/draft',
    });

    // Trigger fast refresh for toggle map (issue with sizing from display:none) - awaiting for better solution
    const displayMapButton = document.querySelector("#display-map-button input");
    displayMapButton.addEventListener('click', (event) => {
      setTimeout(function() { map.resize()}, 80);
    })

    // Display markers on map
    const markers = JSON.parse(mapElement.dataset.markers);
    const test = JSON.parse(mapElement.dataset.test);
    const mapMarkers = []
    markers.forEach((marker) => {
      const popup = new mapboxgl.Popup().setHTML(marker.infoWindow);
      const newMarker = new mapboxgl.Marker()
        .setLngLat([ marker.lng, marker.lat ])
        .setPopup(popup)
        .addTo(map);
      mapMarkers.push(newMarker);
      newMarker.getElement().dataset.markerId = marker.id;
      newMarker.getElement().addEventListener('mouseenter', (e) => toggleCardHighlighting(e) );
      newMarker.getElement().addEventListener('mouseleave', (e) => toggleCardHighlighting(e) );
    });
    if (markers.length != 0) {
      fitMapToMarkers(map, markers);
      openInfoWindow(mapMarkers);
    }
  }
};

export { initMapbox };
