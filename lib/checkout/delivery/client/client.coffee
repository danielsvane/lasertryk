$ ->
  $("#complete").on "click", ->
    console.log "plz"
    $.post "/checkout/delivery/save", $("#address-form").serialize(), ->
      window.location = "/checkout/payment"