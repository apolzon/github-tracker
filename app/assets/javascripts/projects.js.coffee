# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://jashkenas.github.com/coffee-script/

$ = jQuery
$.fn.updateFormByType = ->
  $("select", this).change ->
    $.ajax
      type: "GET",
      url: "/projects/" + $(this).val()
      success: (data) ->
        console.log data
