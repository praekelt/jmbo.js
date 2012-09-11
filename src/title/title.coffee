class TitleView extends Backbone.View
    className: 'jmbo-title-view'

    initialize: ->
        # name
        # actionLeft: icon, callback
        # actionRight: icon, callback
        # extraClasses

    render: =>
        @$el.html @options.name

        # a titleview can have many actions, styling is done with CSS.
        @renderAction(action) for action in @options.actions

        return this

    renderAction: (action) =>
        $action = $('<div/>')
            .addClass(action.extraClasses)
            .html(action.name)
            .on 'click', action.callback

        @$el.append $action
        



exports = this
exports.Jmbo = exports.Jmbo ? {}
exports.Jmbo.TitleView = TitleView