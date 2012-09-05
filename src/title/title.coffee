class TitleView extends Backbone.View
    className: 'jmbo-title-view'

    initialize: ->
        # name
        # actionLeft: icon, callback
        # actionRight: icon, callback
        # dropDownMenu; which I guess could be a collection?

    render: =>
        @$el.html @options.name
        if @options.actionLeft?
            @$el.append "LEFTY"

        if @options.actionRight?
            @$el.append "RIGHTY"


exports = this
exports.Jmbo = exports.Jmbo ? {}
exports.Jmbo.TitleView = TitleView
