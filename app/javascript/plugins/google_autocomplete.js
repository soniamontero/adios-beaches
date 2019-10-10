function googleAutocomplete() {
  document.addEventListener("DOMContentLoaded", function() {
    const addressInput = document.getElementById('experience_address');

    if (addressInput) {
      var autocomplete = new google.maps.places.Autocomplete(addressInput, {
        types: [ 'geocode', 'establishment' ]
      });
      google.maps.event.addDomListener(addressInput, 'keydown', function(e) {
        if (e.key === "Enter") {
          e.preventDefault(); // Do not submit the form on Enter.
        }
      });
    }
  });
}

export { googleAutocomplete };
