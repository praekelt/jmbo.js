# we should make a model for this one
class TitleView extends Backbone.View
  className: 'jmbo-title-view'

  initialize: ->
    @template = _.template '<h1><%= title %></h1>'
    @title = 'Untitled'

  render: =>
    @$el.html(@template title: @title)

  setTitle: (title) =>
    @title = title

class ViewController extends Backbone.Model
  defaults:
    container: null
    cacheView: false
    titleView: TitleView
    childView: null
    animation: 'slide'
    title: ''

class ViewControllers extends Backbone.Collection
  model: ViewController

class ViewControllerView extends Backbone.View
  className: 'jmbo-view-controller-view'

  render: =>
    titleView = new (@model.get 'titleView')
    titleView.setTitle @model.get 'title'
    @$el.append titleView.render()

    childView = @model.get 'childView'
    @$el.append @model.get('childView').render()

    return @el   

  animate: (name, callback) =>
    jmbo.view.animate @$el, name, callback
    # TODO: Allow user to specify a direction, also store the animation
    #   in the model, so that you can just "animate away."




class NavigationController extends Backbone.View
  className: 'jmbo-navigation-controller'

  initialize: ->
    @viewControllers = new ViewControllers

  render: =>  
    @$el.html ''
    return @el

  popViewController: =>
    # remove page off the collection, 
    activeVC = @viewControllers.pop()
    activeVC_View = activeVC.get 'container'
    activeVC_View.animate 'slide-right-out', ->
      activeVC_View.$el.html('').remove()
      delete activeVC

    # slide the new one in.
    if (@viewControllers.length > 0)
      viewController = @viewControllers.last()
      viewControllerView = new ViewControllerView(model: viewController)
      viewController.set container: viewControllerView
      @$el.prepend viewControllerView.render()
      viewControllerView.animate 'slide-left-in'

  pushViewController: (viewController) =>
    # do we have a current vc, animate it away, and delete the "render."
    if (@viewControllers.length > 0)
      activeVC = @viewControllers.last()
      activeVC_View = activeVC.get 'container'
      activeVC_View.animate 'slide-left-out', ->
        activeVC_View.$el.remove()
        activeVC.unset 'container' # kill the pageView.

    @viewControllers.add viewController
    # create a new vc view.
    vcView = new ViewControllerView(model: viewController) 
    # store reference to view in model.
    viewController.set container: vcView
    @$el.append vcView.render()
    vcView.animate 'slide-right-in'

    return viewController




namespace 'jmbo.view', (exports) ->
  exports.Controller = ViewController
  exports.TitleView = TitleView  

  exports.animate = ($el, className, callback) ->  #TODO: add direction.
    $el.addClass className
    $el.on 'webkitAnimationEnd', ->
      $el.removeClass(className).off 'webkitAnimationEnd'
      if callback then callback()


namespace 'jmbo.navigation', (exports) ->
  exports.Controller  = NavigationController
