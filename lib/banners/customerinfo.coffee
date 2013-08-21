$ ->
  $("#complete").on "click", ->
    data = $("#address-form").serialize()
    $.post "/savecustomerinfo", data, (res) ->
      console.log res