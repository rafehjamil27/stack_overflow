// # Place all the behaviors and hooks related to the matching controller here.
// # All this logic will automatically be available in application.js.
// # You can use CoffeeScript in this file: http://coffeescript.org/
$(document).on('change', '.admin-checkbox', function(){
  $.ajax({ 
    type: "POST",
    url: "/users/" + $(this).attr("data-user-id") + "/toggle_active",
    dataType: 'json',
    success: function(result, textStatus, xhr){
      console.log("checking");
    },
    error: function(xhr, textStaus, errorThrown){
      console.log(xhr);
      console.log(errorThrown);
    }
  });
});