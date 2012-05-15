class TitleView extends Backbone.View
  className: 'jmbo-ui-title-view'

  initialize: ->
    @template = _.template '<h1><%= title %></h1>'
    @title = 'Untitled'

  render: =>
    @$el.html(@template title: @title)

  setTitle: (title) =>
    @title = title



class ViewController extends Backbone.Model
  defaults:
    titleView: null
    childView: null
    title: ''
    icon: null
    _view: null
    _selected: false
    
class ViewControllers extends Backbone.Collection
  model: ViewController

class ViewControllerView extends Backbone.View
  className: 'jmbo-ui-view-controller-view'

  render: =>
    # model and model.childView are required to `render.`
    return false if not @model?
    
    # render the titleView.
    titleView = @model.get 'titleView'
    l titleView
    if not titleView?
      titleView = new jmbo.ui.TitleView
    titleView.setTitle @model.get 'title'
    @$el.html titleView.render()
    # render the childView and append it to $el.
    childView = @model.get 'childView'
    return false if not childView?
    @$el.append @model.get('childView').render()

    return @el   

  animate: (name, direction, callback) =>
    jmbo.ui.animate @$el, name, direction, callback







class NavigationControllerView extends Backbone.View
  className: 'jmbo-ui-navigation-controller-view'

  initialize: ->
    # usually a collection is passed to a view.
    @collection = null
    @collection = new jmbo.ui.ViewControllers

  render: =>  
    @$el.html ''
    return @el

  pop: (options={animation: 'slide-left'}) =>
    currentVC = @collection.pop()
    return null if not currentVC?
    currentVC_view = currentVC.get '_view'
    currentVC_view.animate options.animation, 'out', ->
      currentVC_view.$el.html('').remove()
      currentVC.unset '_view'

    if (@collection.length > 0)
      prevVC = @collection.last()
      prevVC_view = new jmbo.ui.ViewControllerView(model: prevVC)
      prevVC.set _view: prevVC_view
      @$el.prepend prevVC_view.render()
      prevVC_view.animate options.animation, 'in'

    return currentVC


  push: (nextVC, options={animation: 'slide-right'}) =>
    if (@collection.length > 0)
      currentVC = @collection.last()
      currentVC_view = currentVC.get '_view'
      currentVC_view.animate options.animation, 'out', ->
          currentVC_view.$el.html('').remove()
          currentVC.unset '_view'

    @collection.add nextVC
    nextVC_view = new jmbo.ui.ViewControllerView(model: nextVC) 
    nextVC.set _view: nextVC_view
    @$el.append nextVC_view.render()
    nextVC_view.animate options.animation, 'in'
    return nextVC























namespace 'jmbo.ui', (exports) ->
  # most of the time these will be hidden from you.
  # jmbo.ui.View*
  exports.ViewController = ViewController
  exports.ViewControllers = ViewControllers
  exports.ViewControllerView = ViewControllerView

  #jmbo.ui.Title
  exports.TitleView = TitleView

  #jmbo.ui.Navigation*
  exports.NavigationControllerView = NavigationControllerView


  exports.animate = ($el, name, direction, callback) ->
    className = name + '-' + direction
    $el.addClass className
    $el.on 'webkitAnimationEnd', ->
      $el.removeClass(className).off 'webkitAnimationEnd'
      if callback then callback()