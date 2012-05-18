class BarItemView extends Backbone.View
  tagName: 'li'
  className: 'jmbo-ui-tab-bar-item-view'

  events:
    'click': 'select'

  initialize: ->
    l 'jmbo.ui.tab.BarItemView -> init'
    @model.on 'change:selected', @renderSelected

  select: =>
    that = @
    for controller in @model.collection.where(selected: true)
      do ->
          controller.set selected: false
    @model.set selected: true

  render: =>
    l 'jmbo.ui.tab.BarItemView -> render'
    controllerViewConfig  = @model.get('view').model
    @$el.html controllerViewConfig.get 'title'
    #@$el.icon controllerViewConfig.get 'icon' #TODO pseudo code
    return @el

  renderSelected: =>
    @$el.toggleClass 'selected'



class BarView extends Backbone.View
  tagName: 'ul'
  className: 'jmbo-ui-tab-bar-view'

  initialize: ->
    l 'jmbo.ui.tab.BarView -> init'
    @collection.on 'reset add', @render

  render: =>
    l 'jmbo.ui.tab.BarView -> render'
    @$el.html ''
    that = @
    @collection.each (model) ->
      that.$el.append new BarItemView(model: model).render()
    return @el




class ControllerView extends jmbo.ui.view.ControllerView
  className: 'jmbo-ui-tab-controller-view'

  initialize: ->
    ControllerView.__super__.initialize.apply this, arguments
    l 'jmbo.ui.tab.ControllerView -> init'

    @collection = null
    @collection = new jmbo.ui.view.Controllers
    @collection.on 'change:selected', @renderSelected

  render: =>
    l 'jmbo.ui.tab.ControllerView -> render'
    @$el.html '<div id="jmbo-ui-tab-controller-view-context"></div>'

    bar = new BarView collection: @collection
    @$el.append bar.render()

    return @el

  renderSelected: =>
    l 'render selected'
    # grab the selected view.
    controller = @collection.where(selected: true)
    if controller.length
      controllerView =  controller[0].get 'view'
      @$el.find('#jmbo-ui-tab-controller-view-context').html controllerView.render()


  set: (controllerViews...) =>
    @collection.reset [], silent: true
    that = @
    for view in controllerViews
      do ->
        that.collection.add view: view, selected: false, {silent: true}
    @collection.trigger 'reset'
    # select the first tab bar
    @selectedIndex 0

  selectedIndex: (i) =>
    for controller in @collection.where(selected: true)
      do ->
        controller.set selected: false
    @collection.at(i).set selected: true


namespace 'jmbo.ui.tab', (exports) ->
  exports.ControllerView  = ControllerView