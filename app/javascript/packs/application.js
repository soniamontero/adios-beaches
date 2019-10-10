import "bootstrap";
// import "../plugins/init_autocomplete.js"

import { googleAutocomplete } from '../plugins/google_autocomplete';
import { photoPreview } from './photo_preview.js';

photoPreview();
googleAutocomplete();

// Coming from Algolia
// import { initAutocomplete } from '../plugins/init_autocomplete';
// initAutocomplete();
