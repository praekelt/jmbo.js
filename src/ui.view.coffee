class Controller extends Backbone.Model
    defaults:
        view: undefined
    
class Controllers extends Backbone.Collection
  model: Controller

class Config extends Backbone.Model
  defaults:
    TitleView: jmbo.ui.TitleView
    view: undefined
    title: 'Untitled'
    icon: undefined

class ControllerView extends Backbone.View
  className: 'jmbo-ui-view-controller-view'

  initialize: ->
    @config = new Config @options

  render: =>
    l 'render called'
    TitleView = @config.get 'TitleView'
    if TitleView?
        titleView = new TitleView
        titleView.setTitle @config.get 'title'
        @$el.html titleView.render()

    view = @config.get 'view'
    if view?
      if view.render? # checking to see if this a controller view or an el?
        viewEl = view.render()
      else
        viewEl = $(view).html()
      @$el.append viewEl

    return @el   

  animate: (name, direction, callback) =>
    jmbo.ui.animate @$el, name, direction, callback



namespace 'jmbo.ui.view', (exports) ->
  exports.Controller = Controller
  exports.Controllers = Controllers
  exports.ControllerView = ControllerView