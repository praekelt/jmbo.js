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
    animation: 'slide'

    _view: null
    

    


class ViewControllers extends Backbone.Collection
  model: ViewController


class ViewControllerView extends Backbone.View
  className: 'jmbo-view-controller-view'

  render: =>
    
    return false if not @model?
    
    titleView = new (@model.get 'titleView')
    titleView.setTitle @model.get 'title'
    @$el.append titleView.render()

    childView = @model.get 'childView'
    return false if not childView?
    
    @$el.append @model.get('childView').render()


    return @el   

  animate: (name, direction, callback) =>

    $el = @$el
    className = name + '-' + direction
    $el.addClass className
    $el.on 'webkitAnimationEnd', ->
      $el.removeClass(className).off 'webkitAnimationEnd'
      if callback then callback()

    




class NavigationControllerView extends Backbone.View
  className: 'jmbo-navigation-controller-view'

  initialize: ->

    @collection = null
    @collection = new ViewControllers
    

  render: =>  
    @$el.html ''
    return @el

  pop: =>
    currentVC = @collection.pop()
    return null if not currentVC?
    currentVC_view = currentVC.get '_view'
    # animate the view out of the viewport;
    currentVC_view.animate currentVC.get('animation'), 'left-out', ->
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
      prevVC_view.animate prevVC.get('animation'), 'left-in'

    return currentVC


  push: (nextVC) =>
    # do we have a current vc, animate it away, and delete the "view.""
    if (@collection.length > 0)
      currentVC = @collection.last()
      currentVC_view = currentVC.get '_view'
      currentVC_view.animate currentVC.get('animation'), 'right-out', ->
          currentVC_view.$el.html('').remove()
          currentVC.unset '_view'
          # Todo; cache the dom stuff, also figure out wtf is going on here.


    @collection.add nextVC
    nextVC_view = new ViewControllerView(model: nextVC) 
    # store reference to view in model. why do we do this? I guess it's because
    # we can't get to the view object any other way via this controller.
    nextVC.set _view: nextVC_view
    @$el.append nextVC_view.render()
    nextVC_view.animate nextVC.get('animation'), 'right-in'
    return nextVC




namespace 'jmbo.view', (exports) ->
  exports.Controller = ViewController
  exports._ControllerView = ViewControllerView

  exports.TitleView = TitleView

namespace 'jmbo.navigation', (exports) ->
  exports.ControllerView  = NavigationControllerView
  exports.TabBarControllerView  = NavigationControllerView
