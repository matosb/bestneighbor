//= require jquery
//= require jquery_ujs
//= require bootstrap-sprockets
//= require bootstrap
//= require bootstrap-datepicker.min
//= require bootstrap-datepicker.fr.min
//= require jquery-fileupload/basic
//= require cloudinary/jquery.cloudinary
//= require attachinary
//= require_tree .

$(document).ready(function() {

// Gestion saisie date pour les listes et trajets avec le plugin datepicker

$('.date').datepicker({
    format: "yyyymmdd",
    weekStart: 1,
    language: "fr",
    autoclose: true,
    todayHighlight: true
});

/*$('.nbpass').on('focus', function() {
  console.log("focus");
});*/


/*
var hiddenCaddy = $( ".caddy");
var hiddenHand = $( ".hand");
var hiddenMail = $( ".mail");
var hiddenContact = $( ".contact");
hiddenCaddy.hide();
hiddenHand.hide();
hiddenMail.hide();
hiddenContact.hide();
$( "#list-subtitle1" ).on( "click", function( event ) {
  hiddenCaddy.show("slow");
});
$( ".caddy" ).on( "click", function( event ) {
  hiddenHand.show("slow");
});
*/

});
