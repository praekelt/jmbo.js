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
    className = name + '-' + direction
    $el.addClass className
    $el.on 'webkitAnimationEnd', ->
      # remove the animation event, otherwise it'll fire for all animations
      # perhaps we should check that the elements match. TODO.
      $el.off 'webkitAnimationEnd'
      $el.removeClass(className)
      if callback then callback()

    # the callback doesn't fire if no animation occured, this might be a 
    # bit hacky...
    if name == 'none'
      $el.trigger('webkitAnimationEnd')