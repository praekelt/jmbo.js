class TabBarItemView extends Backbone.View
  tagName: 'li'
  className: 'jmbo-ui-tab-bar-item-view'

  events:
    'click': 'select'

  initialize: ->
    @model.on 'change:_selected', @render

  render: =>
    vc = @model.toJSON()
    @$el.html vc.title 
    @$el.removeClass 'selected'
    if vc._selected
      @$el.addClass 'selected'

    return @el

  select: =>
    _.each @model.collection.where(_selected: true), (selectedModel) ->
      selectedModel.set _selected: false
    @model.set _selected: true


class TabBarView extends Backbone.View
  tagName: 'ul'
  className: 'jmbo-ui-tab-bar-view'

  initialize: ->
    @collection.on 'reset add', @render

  render: =>
    $el = @$el
    $el.html ''
    @collection.each (model) ->
      tabBarItemView = new TabBarItemView(model: model)
      $el.append tabBarItemView.render()

    
    return @el


class TabBarControllerView extends Backbone.View
  className: 'jmbo-ui-tab-bar-controller-view'

  initialize: ->
    @collection = null
    @collection = new jmbo.ui.ViewControllers


  render: =>
    tabBar = new TabBarView collection: @collection
    @$el.html tabBar.render()

    # we should draw the tab bar at the bottom?
    # it'll have a space in which the child view can render.
    # ok, whenever a new tab bar is added or removed.
    # we need to re-render the tab bar part of the app
    # but not really the whole app.

    return @el

  set: (viewControllers...) =>
    @collection.reset viewControllers
    # set the first element as selected.
    @selectedIndex 0 

  selectedIndex: (i) =>
    # first, deselect all previous selected then select.
    _.each @collection.where(_selected: true), (selectedModel) ->
      selectedModel.set _selected: false

    @collection.at(i).set '_selected': true


namespace 'jmbo.ui', (exports) ->
  exports.TabBarControllerView  = TabBarControllerView