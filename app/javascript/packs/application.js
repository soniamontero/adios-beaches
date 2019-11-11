import "bootstrap";
import 'mapbox-gl/dist/mapbox-gl.css'; // <-- you need to uncomment the stylesheet_pack_tag in the layout!

// import "../plugins/init_autocomplete.js"
import { initMapbox } from '../plugins/init_mapbox';
import { googleAutocomplete } from '../plugins/google_autocomplete';
import { photoPreview } from './photo_preview.js';

initMapbox();
photoPreview();
googleAutocomplete();

// Coming from Algolia
// import { initAutocomplete } from '../plugins/init_autocomplete';
// initAutocomplete();
