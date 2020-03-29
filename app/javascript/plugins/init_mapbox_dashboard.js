import mapboxgl from 'mapbox-gl';

const initMapboxDash = () => {
  const mapMarkers = [];

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

  // Set the 3 different types of markers (my experiences, favorites and dones)
  const setMarkers = (markers, map) => {
    markers.forEach((marker) => {
      const popup = new mapboxgl.Popup().setHTML(marker.infoWindow);

      // Create a HTML element for your custom marker
      const element = document.createElement('div');
      element.className = 'marker';
      element.style.backgroundImage = `url('${marker.image_url}')`;
      element.style.backgroundSize = 'contain';
      element.style.width = '45px';
      element.style.height = '45px';

      // Pass the element as an argument to the new marker
      const newMarker = new mapboxgl.Marker(element)
        .setLngLat([marker.lng, marker.lat])
        .setPopup(popup)
        .addTo(map);
      mapMarkers.push(newMarker);
      // We use the "getElement" funtion provided by mapbox-gl to access to the marker's HTML an set an id
      newMarker.getElement().dataset.markerId = marker.id;
      // Put a microphone on the new marker listening for a mouseenter event
      newMarker.getElement().addEventListener('mouseenter', (e) => toggleCardHighlighting(e) );
      // We put a microphone on listening for a mouseleave event
      newMarker.getElement().addEventListener('mouseleave', (e) => toggleCardHighlighting(e) );
    });
  }

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
      setTimeout(function() { map.resize()}, 80);
    })
    console.log("I love you ❤️");

    // Retrieve markers from dataset
    const myExperiencesMarkers = JSON.parse(mapElement.dataset.experiencesmarkers);
    const favoritesMarkers = JSON.parse(mapElement.dataset.favoritesmarkers);
    const donesMarkers = JSON.parse(mapElement.dataset.donesmarkers);

    // Display markers on map
    setMarkers(myExperiencesMarkers, map);
    setMarkers(favoritesMarkers, map);
    setMarkers(donesMarkers, map);

    const allMarkers = donesMarkers.concat(myExperiencesMarkers, favoritesMarkers);
    if (allMarkers.length !== 0) {
      fitMapToMarkers(map, allMarkers);
      openInfoWindow(mapMarkers);
    }
  }
};

export { initMapboxDash };
