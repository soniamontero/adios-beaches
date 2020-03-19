import mapboxgl from 'mapbox-gl';

const initMapboxDash = () => {
  const mapElement = document.getElementById('dashboard-map');

  const fitMapToMarkers = (map, markers) => {
    const bounds = new mapboxgl.LngLatBounds();
    markers.forEach(marker => bounds.extend([ marker.lng, marker.lat ]));
    map.fitBounds(bounds, { padding: 70, maxZoom: 15, duration: 0 });
  };


  if (mapElement) {
    let markers;
    // Build the map
    mapboxgl.accessToken = mapElement.dataset.mapboxApiKey;
    const map = new mapboxgl.Map({
      container: 'dashboard-map',
      center: [2.3514992, 48.8566101],
      style: 'mapbox://styles/socksss/ck2tzd3ep4a8k1cryts4bpuqb/draft',
    });

    // Trigger fast refresh for toggle map (issue with sizing from display:none) - awaiting for better solution
    const displayMapButton = document.querySelector("#display-map-button input");
    displayMapButton.addEventListener('click', (event) => {
      setTimeout(function() { map.resize()}, 100);
    })

    // Display markers on map
    const myExperiencesMarkers = JSON.parse(mapElement.dataset.experiencesmarkers);
    const favoritesMarkers = JSON.parse(mapElement.dataset.favoritesmarkers);
    const donesMarkers = JSON.parse(mapElement.dataset.donesmarkers);

    myExperiencesMarkers.forEach((marker) => {
      const popup = new mapboxgl.Popup().setHTML(marker.infoWindow);

      // Create a HTML element for your custom marker
      const element = document.createElement('div');
      element.className = 'marker';
      element.style.backgroundImage = `url('${marker.image_url}')`;
      element.style.backgroundSize = 'contain';
      element.style.width = '25px';
      element.style.height = '25px';

      // Pass the element as an argument to the new marker
      new mapboxgl.Marker(element)
        .setLngLat([marker.lng, marker.lat])
        .setPopup(popup)
        .addTo(map);

    });
    favoritesMarkers.forEach((marker) => {
      const popup = new mapboxgl.Popup().setHTML(marker.infoWindow);

      // Create a HTML element for your custom marker
      const element = document.createElement('div');
      element.className = 'marker';
      element.style.backgroundImage = `url('${marker.image_url}')`;
      element.style.backgroundSize = 'contain';
      element.style.width = '25px';
      element.style.height = '25px';

      // Pass the element as an argument to the new marker
      new mapboxgl.Marker(element)
        .setLngLat([marker.lng, marker.lat])
        .setPopup(popup)
        .addTo(map);
    });
    donesMarkers.forEach((marker) => {
      const popup = new mapboxgl.Popup().setHTML(marker.infoWindow);

      // Create a HTML element for your custom marker
      const element = document.createElement('div');
      element.className = 'marker';
      element.style.backgroundImage = `url('${marker.image_url}')`;
      element.style.backgroundSize = 'contain';
      element.style.width = '25px';
      element.style.height = '25px';

      // Pass the element as an argument to the new marker
      new mapboxgl.Marker(element)
        .setLngLat([marker.lng, marker.lat])
        .setPopup(popup)
        .addTo(map);
    });


    markers = donesMarkers.concat(myExperiencesMarkers, favoritesMarkers);
    fitMapToMarkers(map, markers);
  }
};

export { initMapboxDash };
