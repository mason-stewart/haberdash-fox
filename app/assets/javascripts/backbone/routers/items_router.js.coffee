class HaberdashFox.Routers.ItemsRouter extends Backbone.Router
  initialize: (options) ->
    @items = new HaberdashFox.Collections.ItemsCollection()
    @items.reset options.items

    @collections = new HaberdashFox.Collections.CollectionsCollection()
    @collections.reset options.collections

    $(document).on "click", "a:not([data-bypass])", (evt) ->
      href = $(@).attr("href")
      protocol = @protocol + "//"
      if href.slice(protocol.length) isnt protocol
        evt.preventDefault()
        window.router.navigate href, true

  routes:
    ""                    : "index"
    "items/:slug"         : "item"
    "collection/:slug"    : "collection"

  index: ->
    collection = @collections.first()

    @view = new HaberdashFox.Views.Collections.ShowView(model: collection)
    $("#js-content").html(@view.render().el)
    window.scrollTo(0,0)

  item: (slug) ->
    item = @items.get(slug)

    @view = new HaberdashFox.Views.Items.ShowView(model: item)
    $("#js-content").html(@view.render().el)
    window.scrollTo(0,0)

  collection: (slug) ->
    collection = @collections.get(slug)

    @view = new HaberdashFox.Views.Collections.ShowView(model: collection)
    $("#js-content").html(@view.render().el)
    window.scrollTo(0,0)