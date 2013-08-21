$ ->
  $("#complete").on "click", ->
    data = $("#address-form").serialize()
    $.post "/savedeliveryinfo", data, (success) ->
      $("#address-container").prepend("<div class='alert alert-success'>Et ordrenummer er blevet sendt til din email</div>")