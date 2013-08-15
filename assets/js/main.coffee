$ ->
  updateInfo = (info) ->
    $("#width").val(info.initialValues.width)
    $("#height").val(info.initialValues.height)
    $("#amount").val(info.initialValues.amount)
    # Update the treatment options
    updateSelect "treatment", info.treatmentOptions
    # Update the print method options
    updateSelect "printMethod", info.printMethods
    # Set the new price
    $("#price").text(info.price + " DKR")

  updateSelect = (id, options) ->
    $("#"+id).empty()
    for option in options
      $("#"+id).append $("<option #{if option.selected then "selected"}></option>").attr("value", option.key).text(option.val)

  getInfo = ->
    $.get "http://localhost:58989/api/product_price.aspx",
      width: $("#width").val()
      height: $("#height").val()
      amount: $("#amount").val()
      treatment: $("#treatment").val()
    , (data) ->
      console.log data
      updateInfo(data)

  getInfo()

  $("#treatment, #width, #height, #amount").change ->
    getInfo()
  $("#calculate").on "click", ->
    getInfo()

  $("#send").on "click", ->
    $.get "http://localhost:58989/api/getordernumber.aspx", (orderNumber) ->
      postData = $("#product-form, #address-form").serialize()+"&orderNumber="+orderNumber
      $.post "/upload", postData
      $("#modal").modal("toggle")
      $("#price-container").prepend("<div class='alert alert-success'>Ordre oprettet med ordrenummer <strong>#{orderNumber}</strong></div>")