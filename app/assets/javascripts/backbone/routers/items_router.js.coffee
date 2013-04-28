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
    throttledScroll = _.throttle(loadVisibleImages, 500)
    $(window).on 'scroll', throttledScroll
    $ -> loadVisibleImages()

  routes:
    ""                    : "index"
    "items/:slug"         : "item"
    "collection/:slug"    : "collection"

  index: ->
    @collection(HaberdashFox.FeaturedCollectionSlug)

  item: (slug) ->
    if item = @items.get(slug)
      @renderItem(item)
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
    loadVisibleImages()
    @initSlider()

  collection: (slug) ->
    if collection = @collections.get(slug)
      @renderCollection(collection)
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
    loadVisibleImages()

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

loadVisibleImages = ->
  $(".item").each ->
    unless $(@).attr('style')
      if inView($(this), 300)
        $(@).parent().addClass('loading')
        if HaberdashFox.CachedImages[$(@).attr('data-src')]
          $(@).attr('style', "background-image: url(#{$(@).attr('data-src')});" )
        else
          $('<img/>').attr('src', $(@).attr("data-src")).load =>
            $(@).attr('style', "background-image: url(#{$(@).attr('data-src')});" )
            HaberdashFox.CachedImages.push $(@).attr('data-src')

inView = (elem, nearThreshold) ->
  viewportHeight = $(window).height()
  scrollTop = ((if document.documentElement.scrollTop then document.documentElement.scrollTop else document.body.scrollTop))
  elemTop = elem.offset().top
  elemHeight = elem.height()
  nearThreshold = nearThreshold or 0
  return true  if (scrollTop + viewportHeight + nearThreshold) > (elemTop + elemHeight)
  false
