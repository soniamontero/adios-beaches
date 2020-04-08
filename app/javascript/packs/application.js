// import $ from 'jquery';
// global.$ = $;
// global.jQuery = $;

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
import { initSweetalert } from '../plugins/sweet_alert';
import { activeIconIndex } from '../components/active_icon_index';
import { newExperienceCategories } from '../components/new_experience_categories';

initMapbox();
initMapboxDash();
photoPreview();
googleAutocomplete();
toggleMap();
toggleDashMap();
dashboardNav();
updateCharactersLeft();
activeIconIndex();
newExperienceCategories();

// Sweet alert srtup options
initSweetalert('#sweet-alert-unauthorized', {
  title: "You can't delete that check",
  text: "Your experiences are automatically labelled as done.",
  icon: "info",
  button: {
    text: "Ok",
  },
  timer: 2500
});



