class TitleView extends Backbone.View
  className: 'jmbo-ui-title-view'

  initialize: ->
    @template = _.template '<h1><%= title %></h1>'
    @title = 'Untitled'

  render: =>
    @$el.html(@template title: @title)

  setTitle: (title) =>
    @title = title




namespace 'jmbo.ui', (exports) ->
  #jmbo.ui.Title
  exports.TitleView = TitleView


  exports.animate = ($el, name, direction, callback) ->
    ###
    This function had a race condition problem:

    If you added many views to a navigation controller it's possible to add two
    animations to an element at the same time.

    The `in` animation would complete and remove the `animationEnd` callback, 
    which would inturn remove the callback for the `out` animation.

    So the `out` animation's callback would never fire. I've implemented custom
    events specific to the type of animation. `animationEnd` always fires, and
    triggers a custom event. The custom event can be removed without fear of
    removing any other callbacks.
    ###
    className = name + '-' + direction
    customAnimationEvent = 'anim-event-' + className
    $el.addClass className

    # custom events to prevent race condition of having multiple `animationEnd`
    # callbacks on the same object.
    $el.on customAnimationEvent, (e) ->
      $el.off customAnimationEvent
      $el.removeClass className
      if callback then callback()

    # use standard events to fire events specific to the exact type of animation
    # occuring. This is here to prevent a race condition if an in and out
    # event are fired at the same time.
    $el.on 'webkitAnimationEnd animationEnd', (e) ->
      $el.trigger customAnimationEvent
      
      
    # callbacks don't fire if no animation is called. This is a bit hacky.
    # I don't really know how to determine if a class exists.
    # TODO: Determine if a class exists.
    if name == 'none'
      $el.trigger customAnimationEvent