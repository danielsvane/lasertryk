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
    $.get "http://www.lasertryk.dk/api/product_price.aspx",
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

  $("#upload").on "click", ->
    data = $("#product-form").serialize() + "&price=" + $("#price").text()
    $.post "/saveproductinfo", data, (res) ->
      window.location = "/products/banners/upload"