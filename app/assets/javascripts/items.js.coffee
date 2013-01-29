# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://jashkenas.github.com/coffee-script/

slideChange = (args) ->
  $(".slide-selectors .item").removeClass "selected"
  $(".slide-selectors .item:eq(" + (args.currentSlideNumber - 1) + ")").addClass "selected"

$(document).ready ->
  slider = $(".iosSlider")
  slider.iosSlider
    desktopClickDrag: true
    snapToChildren: true
    infiniteSlider: true
    navSlideSelector: ".slide-selectors .item"
    onSlideChange: slideChange
    autoSlide: true
    scrollbar: true
    scrollbarContainer: ".scrollbar"
    scrollbarMargin: "0"
    scrollbarBorderRadius: "0"
    keyboardControls: true
    navPrevSelector: $('#js-scrollleft')
    navNextSelector: $('#js-scrollright')
