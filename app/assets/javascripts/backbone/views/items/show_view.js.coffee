HaberdashFox.Views.Items ||= {}

class HaberdashFox.Views.Items.ShowView extends Backbone.View
  template: JST["backbone/templates/items/show"]

  render: ->
    console.log 'rendering!'
    @$el.html(@template(@model.toJSON() ))
    return this
