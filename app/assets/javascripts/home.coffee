# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://coffeescript.org/

window.ShopGokko = {}

ShopGokko.fetch_cart = (cartLinkUrl) ->
  $.ajax cartLinkUrl,
    type: 'GET'
    dataType: 'html'
    error: (jqXHR) ->
      console.log 'error'
    success: (data) ->
      $('#link-to-cart').html data
