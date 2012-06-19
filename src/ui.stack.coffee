class ControllerView extends jmbo.ui.view.ControllerView
  className: 'jmbo-ui-stack-controller-view'

  initialize: ->
    # calls jmbo.ui.view.ControllerView.initialize.
    ControllerView.__super__.initialize.apply this, arguments
    @collection = new jmbo.ui.view.Controllers

  render: =>
    @$el.html ''
    controller = @collection.last()
    if controller?
      view = controller.get 'view'
      @$el.html view.render()
    return @el

  push: (newView, opts) =>
    defaultOpts = animation: 'slide-right', cache: false
    opts = _.extend defaultOpts, opts

    # animate out current controller view.
    controller = @collection.last()
    if controller?
      currentView = controller.get 'view'
      currentView.animate opts.animation, 'out', ->
        controller.set '_cache', opts.cache
        if not opts.cache
          currentView.$el.html('').remove()

    # We have to create the container-type-model because you can't store a 
    # `View` in a collection.
    @collection.add 'view': newView
    @$el.append newView.render()
    newView.animate opts.animation, 'in'
    return newView

  pop: (options) =>
    defaultOptions = animation: 'slide-left'
    options = _.extend defaultOptions, options
    # pop off stack, animate out, delete from dom.
    controller = @collection.pop()
    if controller?
      currentView = controller.get 'view'
      currentView.animate options.animation, 'out', ->
        # always remove; because it's now dead to us.
        currentView.$el.html('').remove()

    # grab current view off stack, render to the dom, and animate in.
    controller = @collection.last()
    if controller?
      newView = controller.get 'view'
      if not controller.get '_cache'
        @$el.append newView.render()
      newView.animate options.animation, 'in'

    return currentView #


namespace 'jmbo.ui.stack', (exports) ->
  exports.ControllerView = ControllerView