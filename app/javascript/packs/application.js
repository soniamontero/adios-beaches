
import "bootstrap";
import 'mapbox-gl/dist/mapbox-gl.css'; // <-- you need to uncomment the stylesheet_pack_tag in the layout!

import { initMapbox } from '../plugins/init_mapbox';
import { initMapboxDash } from '../plugins/init_mapbox_dashboard';
import { dashboardNav } from '../components/dashboard_nav';
import { googleAutocomplete } from '../plugins/google_autocomplete';
import { photoPreview } from './photo_preview.js';
import { toggleMap } from '../components/toggleMap.js';
import { toggleDashMap } from '../components/toggleDashMap.js';
import { updateCharactersLeft } from '../components/update_characters_left';

initMapbox();
initMapboxDash();
photoPreview();
googleAutocomplete();
toggleMap();
toggleDashMap();
dashboardNav();
updateCharactersLeft();

