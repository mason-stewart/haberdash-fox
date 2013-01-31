class HaberdashFox.Models.Collection extends Backbone.Model
  paramRoot: 'item'
  idAttribute: 'slug'

  defaults:
    title: null
    description: null

class HaberdashFox.Collections.CollectionsCollection extends Backbone.Collection
  model: HaberdashFox.Models.Collection
  url: '/collections'
