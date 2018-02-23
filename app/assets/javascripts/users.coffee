document.addEventListener 'turbolinks:load', ->
  $("#avatar-sign-up,#avatar-profile").change (e) ->
    fileName = e.target.files[0].name
    $("#p-sign-up-avatar,#p-profile-avatar").html(fileName)
    return
  return

