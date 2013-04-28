class HaberdashFox.Routers.ItemsRouter extends Backbone.Router
  initialize: (options) ->
    @items = new HaberdashFox.Collections.ItemsCollection()

    @collections = new HaberdashFox.Collections.CollectionsCollection()

    @bind 'all', @_trackPageview

    $(document).on "click", "a:not([data-bypass])", (evt) ->
      href = $(@).attr("href")
      protocol = @protocol + "//"
      if href.slice(protocol.length) isnt protocol
        evt.preventDefault()
        window.router.navigate href, true


    HaberdashFox.CachedImages = []

    throttledScroll = _.throttle((-> loadVisibleImages('.slide, .item')), 500)
    $(window).on 'scroll', throttledScroll

    $ -> loadVisibleImages('.slide, .item')

  routes:
    ""                    : "index"
    "items/:slug"         : "item"
    "collection/:slug"    : "collection"

  index: ->
    @collection(HaberdashFox.FeaturedCollectionSlug)

  item: (slug) ->
    # If we already have it in the collection, just render it
    if item = @items.get(slug)
      @renderItem(item)
    # otherwise fetch it
    else
      item = new HaberdashFox.Models.Item slug: slug
      item.fetch
        success: (model, response, options) =>
          @items.add(model)
          @renderItem(model)

  renderItem: (item) ->
    @view = new HaberdashFox.Views.Items.ShowView(model: item)
    $("#js-content").html(@view.render().el)
    window.scrollTo(0,0)
    # lazy load all slides to load
    loadVisibleImages()
    @initSlider('.slide')

  collection: (slug) ->
    # If we already have it in the collection, just render it
    if collection = @collections.get(slug)
      @renderCollection(collection)
    # otherwise fetch it
    else
      collection = new HaberdashFox.Models.Collection slug: slug
      collection.fetch
        success: (model, response, options) =>
          @collections.add(model)
          @renderCollection(model)

  renderCollection: (collection) ->
    @view = new HaberdashFox.Views.Collections.ShowView(model: collection)
    $("#js-content").html(@view.render().el)
    window.scrollTo(0,0)
    # lazy load all item images
    loadVisibleImages('.item')

  _trackPageview: ->
    url = Backbone.history.getFragment()
    _gaq.push(['_trackPageview', "/#{url}"])


  initSlider: ->
    slider = $(".iosSlider")
    slider.iosSlider
      desktopClickDrag: true
      snapToChildren: true
      infiniteSlider: true
      navSlideSelector: ".slide-selectors .item"
      onSlideChange: @slideChange
      autoSlide: false
      scrollbar: true
      scrollbarContainer: ".scrollbar"
      scrollbarMargin: "0"
      scrollbarBorderRadius: "0"
      keyboardControls: true
      navPrevSelector: $('#js-scrollleft')
      navNextSelector: $('#js-scrollright')


    # Animate the navigation in
    $('#js-mobile-navigation-button').click ->
      $('#js-mobile-navigation td').each (index) ->
        setTimeout(
          (=> $(@).addClass 'active')
        , (index * 50))

    # Animate the navigation out
    $('td a').click ->
      $('#js-mobile-navigation td').each (index) ->
        setTimeout(
          (=> $(@).removeClass 'active')
        , (index * 50))

  slideChange: (args) ->
    $(".slide-selectors .item").removeClass "selected"
    $(".slide-selectors .item:eq(" + (args.currentSlideNumber - 1) + ")").addClass "selected"

loadVisibleImages = (selector) ->
  $(selector).not('loaded').each ->

    # store the element, its data-src, and its current style attribute
    el = $(@)
    imageUrl = el.attr('data-src')
    currentStyle = el.attr('style') || ''

    # if it's within 300px above or below the viewport
    if inView($(this), 300)

      # add the loading gif to the parent <a>
      el.parent('a').addClass('loading')

      # this allows us to call $.load() conditionally
      if HaberdashFox.CachedImages[imageUrl]
        el.attr('style', "background-image: url(#{imageUrl});" )
      else
        # we didn't find the url in the CachedImages array, so preload it
        # with $.load() and set the background-image on the el in
        # the $.load() callback
        $('<img/>').attr('src', imageUrl).load =>
          el.addClass('loaded').attr('style', "background-image: url(#{imageUrl}); " + currentStyle )

          # add this url to this array to prevent calling $.load()
          # again for the same image.
          HaberdashFox.CachedImages.push imageUrl

# Checks the proximity of an element to the viewport.
# Thanks to Pamela Fox for this!
inView = (el, nearThreshold) ->
  viewportHeight = $(window).height()
  scrollTop = $(document).scrollTop()
  elTop = el.offset().top
  elHeight = el.height()
  nearThreshold = nearThreshold or 0
  return true if (scrollTop + viewportHeight + nearThreshold) > (elTop + elHeight)
  false
