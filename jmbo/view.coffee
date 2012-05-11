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
    icon: null
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
    @$el.html titleView.render()

    # render the childView and append it to $el.
    childView = @model.get 'childView'
    return false if not childView?
    @$el.append @model.get('childView').render()

    return @el   

  animate: (name, direction, callback) =>
    jmbo.view.animate @$el, name, direction, callback




class NavigationControllerView extends Backbone.View
  className: 'jmbo-view-navigation-controller-view'

  initialize: ->
    @collection = null
    @collection = new ViewControllers
    # this used to be collection, why did we change this?
    # if we want this to be private, then perhaps just make it _collection;
    # it is afterall a collection.
    

  render: =>  
    @$el.html ''
    # if we have an object in the collection; render it.


    return @el

  pop: (options={animation: 'slide-left'}) =>
    # remove the current view from the collection, animate it out of the viewport
    # and remove it's dom components.
    currentVC = @collection.pop()
    return null if not currentVC?
    currentVC_view = currentVC.get '_view'
    currentVC_view.animate options.animation, 'out', ->
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
    nextVC_view = new ViewControllerView(model: nextVC) 
    nextVC.set _view: nextVC_view
    @$el.append nextVC_view.render()
    nextVC_view.animate options.animation, 'in'
    return nextVC






class TabBarView extends Backbone.View
  className: 'jmbo-view-tab-bar-view'

  initialize: ->
    @template = _.template """
      <% collection.each(function(vc) { console.log(vc) %>
        <div>1<%= vc.title %></div>
      <% }) %>
    """
    @collection.on 'render add', @render

  render: =>
    l 'pew'
    @$el.html @template(collection: @collection)
    return @el




class TabBarControllerView extends Backbone.View
  className: 'jmbo-view-tab-bar-controller-view'

  initialize: ->
    @collection = null
    @collection = new ViewControllers

  render: =>
    tabBar = new jmbo.view.TabBarView collection: @collection
    @$el.html tabBar.render()

    # we should draw the tab bar at the bottom?
    # it'll have a space in which the child view can render.


    # ok, whenever a new tab bar is added or removed.
    # we need to re-render the tab bar part of the app
    # but not really the whole app.

    return @el

  add: (viewController) =>
    @collection.add viewController


  




















namespace 'jmbo.view', (exports) ->
  exports.Controller = ViewController
  exports._ControllerView = ViewControllerView

  exports.TitleView = TitleView

  exports.NavigationControllerView  = NavigationControllerView

  exports.TabBarView = TabBarView
  exports.TabBarControllerView  = TabBarControllerView

  exports.animate = ($el, name, direction, callback) ->
    className = name + '-' + direction
    $el.addClass className
    $el.on 'webkitAnimationEnd', ->
      $el.removeClass(className).off 'webkitAnimationEnd'
      if callback then callback()