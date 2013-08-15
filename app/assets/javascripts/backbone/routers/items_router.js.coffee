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

    # An array for caching images pre-loaded via $.load()
    # See the loadVisibleImages function below.
    HaberdashFox.CachedImages = []

    # Throttle the loadVisibleImage call that's bound
    # to the window's scroll event
    throttledScroll = _.throttle((-> loadVisibleImages('.slide, .item')), 500)
    $(window).on 'scroll', throttledScroll

    # Easier just to call this on both
    $ -> loadVisibleImages('.slide, .item')

  routes:
    # ""                    : "index"
    ""                    : "shops" # temporary for Shops launch
    "items/:slug"         : "item"
    "collection/:slug"    : "collection"
    "shops"               : "shops"

  index: ->
    # Pass the featured collection slug into the collection method
    # below, via the HaberdashFox.FeaturedCollectionSlug,
    # which is set by Rails in appliation.html.slim.
    #
    # This is done because the featured collection slug
    # changes from week to week.
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
          # Add it to the items collection (for fast lookup
          # next time) and render it
          @items.add(model)
          @renderItem(model)

  renderItem: (item) ->
    @view = new HaberdashFox.Views.Items.ShowView(model: item)
    $("#js-content").html(@view.render().el)
    window.scrollTo(0,0)
    # lazy load all slides when the slider is fully loaded
    # loadVisibleImages('.slide') is passed into the iOS constructor
    # in the initSlider method
    @initSlider()

  collection: (slug) ->
    # If we already have it in the collection, just render it
    if collection = @collections.get(slug)
      @renderCollection(collection)
    # otherwise fetch it
    else
      collection = new HaberdashFox.Models.Collection slug: slug
      collection.fetch
        success: (model, response, options) =>
          # Add it to the collections collection (for fast lookup
          # next time) and render it
          @collections.add(model)
          @renderCollection(model)

  renderCollection: (collection) ->
    @view = new HaberdashFox.Views.Collections.ShowView(model: collection)
    $("#js-content").html(@view.render().el)
    window.scrollTo(0,0)
    # lazy load all item images
    loadVisibleImages('.item')

  shops: ->
    if @shopsCollection?
      @renderShops()
    else
      @shopsCollection = new HaberdashFox.Models.Collection
      @shopsCollection.url = '/shops'
      @shopsCollection.fetch
        success: (model) => @renderShops()

  renderShops: ->
    @view = new HaberdashFox.Views.Collections.ShowView
      model: @shopsCollection
      template: JST["backbone/templates/collections/shops"]
    $("#js-content").html(@view.render().el)

    window.scrollTo(0,0)
    # lazy load all item images
    loadVisibleImages('.item')

  _trackPageview: ->
    url = Backbone.history.getFragment()
    _gaq.push(['_trackPageview', "/#{url}"])

  # slider for the single item view
  initSlider: ->
    slider = $(".iosSlider")
    slider.iosSlider
      desktopClickDrag: true
      snapToChildren: true
      infiniteSlider: true
      navSlideSelector: ".slide-selectors .item"
      onSlideChange: @slideChange
      onSliderLoaded: (-> loadVisibleImages('.slide', true))
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

# A lazy-loader for images
loadVisibleImages = (selector, ignoreProximity) ->
  $(selector).not('loadeded').each ->

    # store the element, its data-src, and its current style attribute
    el = $(@)
    imageUrl = el.attr('data-src')
    currentStyle = el.attr('style') || ''

    # if it's within 300px above or below the viewport
    if ignoreProximity || inView($(this), 500)

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
          el.addClass('loadeded').attr('style', "background-image: url(#{imageUrl}); " + currentStyle )

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
