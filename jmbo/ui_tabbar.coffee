class TabBarItemView extends Backbone.View
  tagName: 'li'
  className: 'jmbo-ui-tab-bar-item-view'

  events:
    'click': 'select'

  initialize: ->
    @model.on 'change:_selected', @renderSelected

  render: =>
    vc = @model.toJSON()
    @$el.html vc.title 
    return @el

  renderSelected: =>
    if @model.get '_selected'
      @$el.addClass 'selected'
    else
      @$el.removeClass 'selected'

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
    @collection.on 'change:_selected', @renderSelected

  render: =>
    @$el.append '<div id="jmbo-ui-view-controller-view"></div>'

    tabBar = new TabBarView collection: @collection
    @$el.append tabBar.render()
    return @el

  renderSelected: =>
    # grab the selected view.
    viewController = @collection.where(_selected: true)[0]
    return false if not viewController?

    viewController_view = viewController.get 'childView'
    @$el.find('#jmbo-ui-view-controller-view').html viewController_view.render()

  set: (viewControllers...) =>
    @collection.reset viewControllers
    @selectedIndex 0 

  selectedIndex: (i) =>
    _.each @collection.where(_selected: true), (selectedModel) ->
      selectedModel.set _selected: false
    @collection.at(i).set '_selected': true


namespace 'jmbo.ui', (exports) ->
  exports.TabBarControllerView  = TabBarControllerView