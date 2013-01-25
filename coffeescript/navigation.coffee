$(document).ready ->
  $(".navigation td").fitText 0.2, { minFontSize: '30px', maxFontSize: '40px' }

  # Animate the navigation in
  $('#top span, .home').click ->
    $('.navigation td').each (index) ->
      setTimeout(
        (=> $(@).addClass 'active')
      , (index * 50))

  # Animate the navigation out
  $('td a').click ->
    $('.navigation td').each (index) ->
      setTimeout(
        (=> $(@).removeClass 'active')
      , (index * 50))

  # Change border color when you hit a new section
  $window = $(window)
  colorChange = $('.color-change')
  sections = $('.layout-full').get().reverse()
  $window.scroll ->
    for section in sections
      if $window.scrollTop() - $(section).offset().top > -100
        colorChange.css 'background-color': '#'+$(section).attr('id')
        break
