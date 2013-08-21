$ ->
  $("#complete").on "click", ->
    data = $("#address-form").serialize()
    $.post "/savedeliveryinfo", data, (orderNumber) ->
      $("#address-container").prepend("<div class='alert alert-success'>Ordre oprettet med ordrenummer <strong>#{orderNumber}</strong></div>")