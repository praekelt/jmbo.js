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
    # TODO: allow this to be set.


    @$el.append bar.render()

    return @el

  renderSelected: =>
    controller = @collection.where(selected: true)
    if controller.length
      controllerView = controller[0].get 'view'
      @$el.find('#jmbo-ui-tab-controller-view-context').html ''
      @$el.find('#jmbo-ui-tab-controller-view-context').html controllerView.render()
      controllerView.firePostRenderEvent()
      

  set: (controllerViews...) =>
    @collection.reset [], silent: true
    # if controllersViews is empty then set the collection as empty and trigger
    # the reset event which causes the `TabBarView` to redraw.
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
    # try to do a bit of a getter/ setter thing here. If you don't pass an
    # index then simply return the currently selected Index.
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
