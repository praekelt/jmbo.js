class Controller extends Backbone.Model
    defaults:
        view: null
    
class Controllers extends Backbone.Collection
  model: Controller

class Config extends Backbone.Model
  defaults:
    TitleView: jmbo.ui.TitleView
    childView: null
    title: 'Untitled'
    icon: null

class ControllerView extends Backbone.View
  className: 'jmbo-ui-view-controller-view'

  initialize: ->
    @config = new Config @options

  render: =>
    TitleView = @config.get 'TitleView'
    if TitleView?
        titleView = new TitleView
        titleView.setTitle @config.get 'title'
        @$el.html titleView.render()
    
    childView = @config.get 'childView'
    if childView?
        @$el.append childView.render()

    return @el   

  animate: (name, direction, callback) =>
    jmbo.ui.animate @$el, name, direction, callback



namespace 'jmbo.ui.view', (exports) ->
  exports.Controller = Controller
  exports.Controllers = Controllers
  exports.ControllerView = ControllerView