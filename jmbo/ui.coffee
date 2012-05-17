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

    # there's a race condition here. IN and OUT animations are running at the same 
    # time, so... you start the IN animation, and remove the "animationEnd" event
    # so the OUT animation never gets callled; htf we going to solve this?

    className = name + '-' + direction
    $el.addClass className
    $el.on 'webkitAnimationEnd animationEnd', ->

      l 'this', @

      # remove the animation event, otherwise it'll fire for all animations
      # perhaps we should check that the elements match. TODO.
      $el.off 'webkitAnimationEnd animationEnd'
      $el.removeClass className
      if callback then callback()
      

    # the callback doesn't fire if no animation occured, this might be a 
    # bit hacky...
    if name == 'none'
      $el.trigger('webkitAnimationEnd animationEnd')