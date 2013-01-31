class HaberdashFox.Models.Item extends Backbone.Model
  paramRoot: 'item'
  idAttribute: 'slug'

  defaults:
    title: null
    description: null

class HaberdashFox.Collections.ItemsCollection extends Backbone.Collection
  model: HaberdashFox.Models.Item
  url: '/items'
