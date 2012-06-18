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

  push: (newView, options) =>
    # Default options.
    defaultOptions = animation: 'slide-right'
    options = _.extend defaultOptions, options


    # grab current view from stack, animate out, and delete from dom.
    controller = @collection.last()
    if controller?
      currentView = controller.get 'view'
      currentView.animate options.animation, 'out', ->
          currentView.$el.html('').remove()

    # We have to create the container-type-model because you can't store a 
    # `View` in a collection.
    @collection.add 'view': newView
    @$el.append newView.render()
    newView.animate options.animation, 'in'
    return newView

  pop: (options) =>
    defaultOptions = animation: 'slide-right'
    options = _.extend defaultOptions, options
    # pop off stack, animate out, delete from dom.
    controller = @collection.pop()
    if controller?
      currentView = controller.get 'view'
      currentView.animate options.animation, 'out', ->
        currentView.$el.html('').remove()

    # grab current view off stack, render to the dom, and animate in.
    newController = @collection.last()
    if newController?
      newView = newController.get 'view'
      @$el.append newView.render()
      newView.animate options.animation, 'in'

    return currentView #


namespace 'jmbo.ui.stack', (exports) ->
  exports.ControllerView = ControllerView