$ ->
  $("#complete").on "click", ->
    $.post "/checkout/delivery/save", $("#address-form").serialize(), ->
      window.location = "/checkout/payment"