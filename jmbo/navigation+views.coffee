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
    titleView: TitleView
    childView: null
    title: ''
    _view: null
    

    


class ViewControllers extends Backbone.Collection
  model: ViewController


class ViewControllerView extends Backbone.View
  className: 'jmbo-view-controller-view'

  render: =>
    
    return false if not @model?

    # render the titleView.
    titleView = new (@model.get 'titleView')
    titleView.setTitle @model.get 'title'
    @$el.append titleView.render()

    # render the childView and append it to $el.
    childView = @model.get 'childView'
    return false if not childView?
    @$el.append @model.get('childView').render()

    return @el   

  animate: (name, direction, callback) =>
    jmbo.view.animate @$el, name, direction, callback



class NavigationControllerView extends Backbone.View
  className: 'jmbo-navigation-controller-view'

  initialize: ->

    @collection = null
    @collection = new ViewControllers
    

  render: =>  
    @$el.html ''
    return @el

  pop: (animation='slide') =>

    # remove the current view from the collection, animate it out of the viewport
    # and remove it's dom components.
    currentVC = @collection.pop()
    return null if not currentVC?
    currentVC_view = currentVC.get '_view'
    currentVC_view.animate animation, 'left-out', ->
      currentVC_view.$el.html('').remove()
      currentVC.unset '_view'
      # Todo; ability to cache DOM element.

    #slide the previous view controller in;
    # last_VC.
    if (@collection.length > 0)
      prevVC = @collection.last()
      prevVC_view = new ViewControllerView(model: prevVC)
      prevVC.set _view: prevVC_view
      @$el.prepend prevVC_view.render()
      prevVC_view.animate animation, 'left-in'

    return currentVC


  push: (nextVC, animation='slide') =>
    if (@collection.length > 0)
      currentVC = @collection.last()
      currentVC_view = currentVC.get '_view'
      currentVC_view.animate animation, 'right-out', ->
          currentVC_view.$el.html('').remove()
          currentVC.unset '_view'


    @collection.add nextVC
    nextVC_view = new ViewControllerView(model: nextVC) 
    nextVC.set _view: nextVC_view
    @$el.append nextVC_view.render()
    nextVC_view.animate animation, 'right-in'
    return nextVC




namespace 'jmbo.view', (exports) ->
  exports.Controller = ViewController
  exports._ControllerView = ViewControllerView

  exports.TitleView = TitleView

  exports.animate = ($el, name, direction, callback) ->
    className = name + '-' + direction
    $el.addClass className
    $el.on 'webkitAnimationEnd', ->
      $el.removeClass(className).off 'webkitAnimationEnd'
      if callback then callback()

namespace 'jmbo.navigation', (exports) ->
  exports.ControllerView  = NavigationControllerView
  exports.TabBarControllerView  = NavigationControllerView
