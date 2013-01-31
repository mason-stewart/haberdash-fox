HaberdashFox.Views.Collections ||= {}

class HaberdashFox.Views.Collections.ShowView extends Backbone.View
  template: JST["backbone/templates/collections/show"]

  render: ->
    console.log 'rendering!'
    @$el.html(@template(@model.toJSON() ))
    return this
