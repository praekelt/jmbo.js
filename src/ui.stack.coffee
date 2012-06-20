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
    newView.animate opts.animation, 'in', ->
      if opts.callback then opts.callback()

    return newView

  pop: (opts) =>
    defaultOptions = animation: 'slide-left'
    opts = _.extend defaultOptions, opts

    # pop off stack, animate out, delete from dom.
    controller = @collection.pop()
    if controller?
      currentView = controller.get 'view'
      currentView.animate opts.animation, 'out', ->
        # always remove; because you're now dead to us.
        currentView.$el.html('').remove()
        if opts.callback then opts.callback()

    # grab current view off stack, render to the dom, and animate in.
    controller = @collection.last()
    if controller?
      newView = controller.get 'view'
      if not controller.get '_cache'
        @$el.append newView.render()
      newView.animate opts.animation, 'in'

    return currentView


namespace 'jmbo.ui.stack', (exports) ->
  exports.ControllerView = ControllerView