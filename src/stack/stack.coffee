# Not explicitly required, but helpful when debugging to get objects with names
# rather than just `Model` or `Collection`
class StackViewVessel extends Backbone.Model
class StackViewVessels extends Backbone.Collection
    model: StackViewVessel


animate = ($el, animation, direction, callback) ->
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
    $el.addClass className


class StackView extends Backbone.View
    ###
    A stack is a collection of nested views. The views can be pushed and popped
    off the stack. The stack can:

      * Transition views with CSS animations
      * Keeps track of which state.
      * Can cache elements in the DOM.
    ###

    className: 'jmbo-stack-view'

    initialize: ->
        if not @collection? then @collection = new StackViewVessels
        # defaults
        @options.pushDefaults = _.extend 
            animation: 'slide-right'
            removeFromDOM: true
            ,
            @options.pushDefaults

        @options.popDefaults  = _.extend 
            animation: 'slide-left'
            ,
            @options.popDefaults

    render: =>
        # render the current view and any views which are meant to be cached.
        viewVessels = @collection.where _cache: true
        if @collection.last() then viewVessels.push @collection.last()

        @$el.contents().detach()
        for viewVessel in viewVessels
            @$el.append viewVessel.get('view').render().el

        return this

    push: (newView, options) =>
        opts = {}
        _.extend opts, @options.pushDefaults, options

        # remove the current view out of the way
        currentViewVessel = @collection.last()
        if currentViewVessel?
            currentView = currentViewVessel.get 'view'
            animate currentView.$el, opts.animation, 'out', ->
                # .detach() is the same as .remove() but keeps all the data and 
                # subsequently the events.
                if not opts.removeFromDOM
                    currentViewVessel.set '_cache': not opts.removeFromDOM
                else
                    currentView.$el.detach()

        # and then add the new view, and move it into the way
        @collection.add 'view': newView
        newView.stackView = this
        @$el.append newView.render().el
        animate newView.$el, opts.animation, 'in', ->
            # TODO: trigger `rendered` event
            opts.callback?()


    pop: (options) =>
        opts = {}
        _.extend opts, @options.popDefaults, options
        
        # remove the current view from the collection and the DOM.
        currentView = @collection.pop()?.get 'view'
        animate currentView.$el, opts.animation, 'out', ->
            # remove this view, it's dead to us now.
            delete currentView.stackView
            currentView.$el.remove()
            opts.callback?()
            # TODO: test if this cleans up the memory as well?

        # animate in the previous view
        newViewVessel = @collection.last()
        if newViewVessel?
            newView = newViewVessel.get 'view'
            if not newViewVessel.get '_cache'
                @$el.append newView.render().el
                # TODO: trigger `rendered` event
            animate newView.$el, opts.animation, 'in'


exports = this
exports.Jmbo = exports.Jmbo ? {}
exports.Jmbo.StackView = StackView
