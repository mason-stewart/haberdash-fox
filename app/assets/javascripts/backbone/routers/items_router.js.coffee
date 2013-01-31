class HaberdashFox.Routers.ItemsRouter extends Backbone.Router
  initialize: (options) ->
    @items = new HaberdashFox.Collections.ItemsCollection()
    @items.reset options.items

    console.log @items

    $(document).on "click", "a:not([data-bypass])", (evt) ->
      href = $(@).attr("href")
      protocol = @protocol + "//"
      if href.slice(protocol.length) isnt protocol
        console.log href
        evt.preventDefault()
        window.router.navigate href, true

  routes:
    "items/:slug"      : "show"

  show: (slug) ->
    console.log 'running show'
    item = @items.get(slug)

    @view = new HaberdashFox.Views.Items.ShowView(model: item)
    $("#js-content").html(@view.render().el)
