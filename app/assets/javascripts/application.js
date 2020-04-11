// app/assets/javascript/application.js
//= require rails-ujs
//= require_tree .

if ('serviceWorker' in navigator) {
  navigator.serviceWorker.register('/serviceworker.js');
}
//= require serviceworker-companion
