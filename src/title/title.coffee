class TitleView extends Backbone.View
    className: 'jmbo-title-view'

    initialize: ->
        # name
        # actionLeft: icon, callback
        # actionRight: icon, callback

    render: =>
        @$el.html @options.name
        if @options.actionLeft?
            @$el.append "LEFTY"

        if @options.actionRight?
            @$el.append "RIGHTY"

        return this


exports = this
exports.Jmbo = exports.Jmbo ? {}
exports.Jmbo.TitleView = TitleView
