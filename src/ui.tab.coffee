class BarItemView extends Backbone.View
  tagName: 'li'
  className: 'jmbo-ui-tab-bar-item-view'

  events:
    'click': 'select'

  initialize: ->
    @model.on 'change:selected', @renderSelected

  select: =>
    if @model.get('selected') is true then return
    for controller in @model.collection.where(selected: true)
      do ->
          controller.set selected: false
    @model.set selected: true

  render: =>
    controllerViewConfig  = @model.get('view').config
    @$el.html controllerViewConfig.get 'title'

    # icon
    icon = controllerViewConfig.get 'icon'
    if icon?
      @$el.append  """<div class="icon-#{icon}"></div>"""

    return @el

  renderSelected: =>
    @$el.toggleClass 'selected'

class BarView extends Backbone.View
  tagName: 'ul'
  className: 'jmbo-ui-tab-bar-view'

  initialize: ->
    @collection.on 'reset', @render

  render: =>
    @$el.html ''
    that = @
    @collection.each (model) ->
      that.$el.append new BarItemView(model: model).render()
    return @el

class ControllerView extends jmbo.ui.view.ControllerView
  className: 'jmbo-ui-tab-controller-view'

  initialize: ->
    # calls jmbo.ui.view.ControllerView.initialize
    ControllerView.__super__.initialize.apply this, arguments
    @collection = new jmbo.ui.view.Controllers
    @collection.on 'change:selected', @renderSelected

    @_selectedIndex = 0

  render: =>
    @$el.html '<div id="jmbo-ui-tab-controller-view-context"></div>'
    bar = new BarView collection: @collection
    @$el.append bar.render()
    return @el

  renderSelected: =>
    controllers = @collection.where(selected: true)
    if controllers.length
      controllerView = controllers[0].get 'view'
      if controllerView?
        @$el.find('#jmbo-ui-tab-controller-view-context').html controllerView.render()
        controllerView.firePostRenderEvent()

      

      

  set: (controllerViews...) =>
    @collection.reset [], silent: true

    if controllerViews.length == 0
      @collection.trigger 'reset'
      return  

    that = @
    for view in controllerViews
      do ->
        that.collection.add view: view, selected: false, {silent: true}
    @collection.trigger 'reset'
    @selectedIndex 0

  selectedIndex: (i) =>
    if not i?
      return i = @_selectedIndex

    for controller in @collection.where(selected: true)
      do ->
        controller.set selected: false
    @collection.at(i).set selected: true
    @_selectedIndex = i




namespace 'jmbo.ui.tab', (exports) ->
  exports.ControllerView  = ControllerView

  exports._BarView = BarView
  exports._BarItemView = BarItemView
