$ ->
  $("#price-container").hide()

  $("#calculate").on "click", ->
    console.log "Post request sent to calculate price"
    $.post "/products/businesscards/getprice", $("#product-form").serialize(), (res) ->
      $("#price").html res + " DKK"
      $("#price-container").show()

  $("#upload").on "click", ->
    $("#modal").modal("toggle")

  $("#fileupload").fileupload
    dataType: "json"
    done: (e, data) ->
      window.location = "/checkout/delivery"