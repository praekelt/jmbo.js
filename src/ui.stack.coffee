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

  push: (newView, options={animation: 'slide-right'}) =>
    # grab current view from stack, animate out, and delete from dom.
    controller = @collection.last()
    if controller?
      oldView = controller.get 'view'
      oldView.animate options.animation, 'out', ->
        oldView.$el.html('').remove()

    # We have to create the container-type-model because you can't store a 
    # `View` in a collection.
    @collection.add 'view': newView
    @$el.append newView.render()
    newView.animate options.animation, 'in'
    return newView

  pop: (options={animation: 'slide-left'}) =>
    # pop off stack, animate out, delete from dom.
    oldController = @collection.pop()
    if oldController?
      oldView = oldController.get 'view'
      oldView.animate options.animation, 'out', ->
        oldView.$el.html('').remove()

    # grab current view off stack, render to the dom, and animate in.
    newController = @collection.last()
    if newController?
      newView = newController.get 'view'
      @$el.append newView.render()
      newView.animate options.animation, 'in'

    return oldView


namespace 'jmbo.ui.stack', (exports) ->
  exports.ControllerView = ControllerView