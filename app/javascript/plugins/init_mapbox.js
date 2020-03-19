import mapboxgl from 'mapbox-gl';

const initMapbox = () => {
  const mapElement = document.getElementById('index-map');

  const fitMapToMarkers = (map, markers) => {
    const bounds = new mapboxgl.LngLatBounds();
    markers.forEach(marker => bounds.extend([ marker.lng, marker.lat ]));
    map.fitBounds(bounds, { padding: 70, maxZoom: 15, duration: 0 });
  };


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
    markers.forEach((marker) => {
      const popup = new mapboxgl.Popup().setHTML(marker.infoWindow);
      new mapboxgl.Marker()
        .setLngLat([ marker.lng, marker.lat ])
        .setPopup(popup)
        .addTo(map);
        fitMapToMarkers(map, markers);
    });
  }
};

export { initMapbox };
