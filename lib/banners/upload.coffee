$ ->
  $("#fileupload").fileupload
    dataType: "json"
    done: (e, data) ->
      console.log "Upload completed"