HaberdashFox.Views.Collections ||= {}

class HaberdashFox.Views.Collections.ShowView extends Backbone.View
  initialize: (options) ->
    @template= options.template || JST["backbone/templates/collections/show"]

  render: ->
    @$el.html(@template(@model.toJSON() ))
    return this
