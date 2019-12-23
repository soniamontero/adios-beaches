// response.setHeader("Set-Cookie", "HttpOnly;Secure;SameSite=Strict");

import "bootstrap";
import 'mapbox-gl/dist/mapbox-gl.css'; // <-- you need to uncomment the stylesheet_pack_tag in the layout!

// import "../plugins/init_autocomplete.js"
import { initMapbox } from '../plugins/init_mapbox';
import { googleAutocomplete } from '../plugins/google_autocomplete';
import { photoPreview } from './photo_preview.js';
import { toggleMap } from '../components/toggleMap.js';
import { updateCharactersLeft } from '../components/update_characters_left';

initMapbox();
photoPreview();
googleAutocomplete();
toggleMap();
updateCharactersLeft();

// Coming from Algolia
// import { initAutocomplete } from '../plugins/init_autocomplete';
// initAutocomplete();
