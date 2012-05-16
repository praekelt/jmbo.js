


class Controller extends Backbone.Model
    defaults:
        view: null
    
class Controllers extends Backbone.Collection
  model: Controller





class ControllerViewConfig extends Backbone.Model
  defaults:
    TitleView: jmbo.ui.TitleView
    childView: null
    title: 'Untitled'
    icon: null

    _view: null
    _selected: false # used for tabbar.


class ControllerView extends Backbone.View
  className: 'jmbo-ui-view-controller-view'

  initialize: ->
    @model = new ControllerViewConfig @options

  render: =>
    l 'ui.view.ControllerView::render'

    TitleView = @model.get 'TitleView'
    if TitleView?
        titleView = new TitleView
        titleView.setTitle @model.get 'title'
        @$el.html titleView.render()
    
    childView = @model.get 'childView'
    if childView?
        @$el.append childView.render()

    return @el   

  animate: (name, direction, callback) =>
    l 'how many time do I get called?'
    jmbo.ui.animate @$el, name, direction, callback



namespace 'jmbo.ui.view', (exports) ->
  exports.Controller = Controller
  exports.Controllers = Controllers
  exports.ControllerView = ControllerView