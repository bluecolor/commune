window.$ = window.jQuery = require("jquery");

// We need to import the CSS so that webpack will load it.
// The MiniCssExtractPlugin is used to separate it out into
// its own CSS file.
import css from "../css/app.scss"

// webpack automatically bundles all modules in your
// entry points. Those entry points can be configured
// in "webpack.config.js".
//
// Import dependencies
//
import "phoenix_html"


// Import local files
//
// Local files can be imported directly using relative paths, for example:
// import socket from "./socket"

import './trends'
import './notification'
import './rich-editor'
import './trix'
import './comment'

if ( window.history.replaceState ) {
  window.history.replaceState( null, null, window.location.href );
}

$(window).click(function() {
  if ($('.dropdown').hasClass('is-active')) {
    $('.dropdown').removeClass('is-active')
  }
});