class TitleView extends Backbone.View
    className: 'jmbo-title-view'

    initialize: ->
        # name
        # actionLeft: icon, callback
        # actionRight: icon, callback
        # extraClasses

    render: =>
        console.log @options
        @$el.html @options.name
        if @options.actionLeft?

            
            @$el.append "LEFTY"

        if @options.actionRight?
            @$el.append @renderAction(@options.actionRight)

        return this

    renderAction: (action) =>
        $action = $('<div/>')
            .addClass(@options.actionRight.extraClasses)
            .html(@options.actionRight.name)
            .on 'click', @options.actionRight.callback
        



exports = this
exports.Jmbo = exports.Jmbo ? {}
exports.Jmbo.TitleView = TitleView
