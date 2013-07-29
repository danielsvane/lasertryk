$ ->
  $("#price").text(500)
  $("#calculate").on "click", ->
    $.get "http://localhost:58989/api/product_price.aspx",
      width: $("#width").val()
      height: $("#height").val()
      amount: $("#amount").val()
    , (data) ->
      $("#price").text(data + " DKR")
      console.log data