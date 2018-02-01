# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://coffeescript.org/
document.addEventListener 'turbolinks:load', ->
  $('#new-image-id').change (e) ->
    fileName = e.target.files[0].name
    $("#p-new-image-button").html(fileName)
    return
  return

$(document).ready ->
  $('#new-image-id').change (e) ->
    fileName = e.target.files[0].name
    $("#p-new-image-button").html(fileName)
    return
  return

