class ControllerView extends jmbo.ui.view.ControllerView
  className: 'jmbo-ui-stack-controller-view'

  initialize: ->
    # calls jmbo.ui.view.ControllerView.initialize.
    ControllerView.__super__.initialize.apply this, arguments
    @collection = new jmbo.ui.view.Controllers

  render: =>
    controllers = @collection.where _cache: true 
    controllers.push @collection.last()

    @$el.html ''
    for controller in controllers
      view = controller.get 'view'
      @$el.append view.render()

    return @el

  firePostRenderEvent: =>
    controllers = @collection.where _cache: true 
    controllers.push @collection.last()
    for controller in controllers
      view = controller.get 'view'
      view.firePostRenderEvent()


  push: (newView, opts) =>
    defaultOpts = animation: 'slide-right', removeFromDom: true
    opts = _.extend defaultOpts, opts

    controller = @collection.last()
    if controller?
      currentView = controller.get 'view'
      currentView.animate opts.animation, 'out', ->
        controller.set '_cache', !opts.removeFromDom
        if opts.removeFromDom
          currentView.$el.html('').remove()

    # We have to create the container model because you can't store a 
    # `View` in a collection.
    @collection.add 'view': newView
    @$el.append newView.render()
    newView.firePostRenderEvent()
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
        newView.firePostRenderEvent()

      newView.animate opts.animation, 'in', 

    return currentView


namespace 'jmbo.ui.stack', (exports) ->
  exports.ControllerView = ControllerView