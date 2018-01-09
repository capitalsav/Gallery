$(document).ready ->
  $('#avatar-sign-up').change (e) ->
    fileName = e.target.files[0].name
    $("#p-sign-up-avatar").html(fileName)
    return
  return

$(document).ready ->
  $('#avatar-profile').change (e) ->
    fileName = e.target.files[0].name
    $("#p-profile-avatar").html(fileName)
    return
  return