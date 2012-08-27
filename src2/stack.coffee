# these are mostly here for debugging purposes, if you console.log out the
# collection of the stack I want it to be obvious about what type of thing it 
# is.
class StackViewVessel extends Backbone.Model
    # pass
class StackViewVessels extends Backbone.Collection
    model: StackViewVessel


animate = ($el, animation, direction, callback) ->
    #console.log $el, animation, direction
    className = "#{animation}-#{direction}"
    eventName = "animation-event-#{className}"

    $el.one eventName, ->
        $el.removeClass className
        callback?()


    if animation is false
        $el.trigger eventName
        return

    $el.on 'webkitAnimationEnd animationEnd', ->
        $el.trigger eventName


class StackView extends Backbone.View
    ###
    A stack is a collection of views that are nested hierarchially. The stacks
    deals with with things like transition animations and weather views should
    be cached or not.
    ###

    className: 'jmbo-stack-view'

    initialize: ->
        if not @collection? then @collection = new StackViewVessels
        @options.pushDefaults = _.extend {animation: 'slide-right', removeViewFromDOM: true}, @options.pushDefaults
        @options.popDefaults  = _.extend {animation: 'slide-left'}, @options.popDefaults

    render: =>
        # grab current view and cached views
        viewVessels = @collection.where _cache: true

        if @collection.last() then viewVessels.push @collection.last()

        @$el.html ''
        for viewVessel in viewVessels
            @$el.append viewVessel.get('view').render().el

        return this

    push: (newView, opts) =>
        opts = _.extend @options.pushDefaults, opts
        # remove the current view out of the way
        currentViewVessel = @collection.last()
        if currentViewVessel?
            currentView = currentViewVessel.get 'view'
            animate currentView.$el, opts.animation, 'out', ->
                # .detach() is the same as .remove() but keeps all the data and 
                # the events events.
                if not opts.removeViewFromDOM
                    currentViewVessel.set '_cache': not opts.removeViewFromDOM
                else
                    currentView.$el.detach()

        # and then add the new view, and move it into the way
        @collection.add 'view': newView
        @$el.append newView.render().el
        animate newView.$el, opts.animation, 'in', ->
            # TODO: trigger `rendered` event
            opts.callback?()


    pop: (opts) =>
        opts = _.extend @options.popDefaults, opts

        # remove the current view from the collection and the DOM.
        currentView = @collection.pop()?.get 'view'
        animate currentView.$el, opts.animation, 'out', ->
            # remove this view, it's dead to us now.
            currentView.$el.remove()
            opts.callback?()
            # TODO: does this clean up the memory as well?

        # animate in the previous view
        newViewVessel = @collection.last()
        if newViewVessel?
            newView = newViewVessel.get 'view'
            if not newViewVessel.get '_cache'
                @$el.append newView.render()
                # TODO: trigger `rendered` event

            animate newView.$el, opts.animation, 'in'


exports = this
exports.Jmbo = exports.Jmbo ? {}
exports.Jmbo.StackView = StackView