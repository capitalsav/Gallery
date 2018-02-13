# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://coffeescript.org/
$(document).ready ->
  setTimeout (->
    $('#flash').remove()
    return
  ), 10000
  return
document.addEventListener 'turbolinks:load', ->
  setTimeout (->
    $('#flash').remove()
    return
  ), 10000
  return
