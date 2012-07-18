class TitleView extends Backbone.View
  className: 'jmbo-ui-title-view'
  template: _.template '<h1><%= title %></h1>'

  initialize: ->
    @title = 'Untitled'

  render: =>
    @$el.html(@template title: @title)

  setTitle: (title) =>
    @title = title

namespace 'jmbo.ui', (exports) ->
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

    # custom event handlers.
    $el.on customAnimationEvent, ->
      $el.off customAnimationEvent
      $el.removeClass className
      if callback then callback()
    # use standard events to fire custom events. This prevents a race condition 
    # if an `in` and `out` event are fired in the same time.
    $el.on 'webkitAnimationEnd animationEnd', (e) ->
      $el.trigger customAnimationEvent
    
    # If the animation is false then the webkitAnimationEnd callback would not fire.
    # Trigger then customAnimationEvent manually.      
    if name is false
      $el.trigger customAnimationEvent