# TODO; this config model is a bit messy;
# what would be nice is if the titleview persists after it's rendered.
# but where do we place it, the view sometimes needs access to this context.
# do we pipe that up the chain? #what do we call it, @config?


# pew pew pew

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

    # pass a reference of config to the view; we do this because sometimes
    # the view might want to access the titleView.
    view = @config.get 'view'
    if view?
      view.controller = this # TODO, woah. Maybe I should rather pass config.

  render: =>
    @$el.html ''
    TitleView = @config.get 'TitleView'
    if TitleView?
      if not @titleView?
        @titleView = new TitleView()

      @$el.html @titleView.render()
      @titleView.setTitle @config.get 'title'

    view = @config.get 'view'
    if view?
      if view.render? # checking to see if this a controller view or an el?
        viewEl = view.render()
      else
        viewEl = $(view).html()

      $(viewEl).addClass 'jmbo-ui-view-controller-view-view'
      @$el.append viewEl

    return @el 

  firePostRenderEvent: =>
    # this view exists because sometimes you need to do something after an
    # element is already added to the dom, before might be too early.
    # so a stack controller fires this event after calling "render..."
    # hopefully it's soon enough.

    view = @config.get 'view'
    if view?
      view.delegateEvents()
      view.trigger 'render:post'


  animate: (name, direction, callback) =>
    jmbo.ui.animate @$el, name, direction, callback



namespace 'jmbo.ui.view', (exports) ->
  exports.Controller = Controller
  exports.Controllers = Controllers
  exports.ControllerView = ControllerView