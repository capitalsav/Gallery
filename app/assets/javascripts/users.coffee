$(document).ready ->
  $('#avatar-sign-up').change (e) ->
    fileName = e.target.files[0].name
    alert 'The file "' + fileName + '" has been selected.'
    $("#p-sign-up-avatar").html(fileName)
    return
  return