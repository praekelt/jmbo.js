# so this is the big one...

# a list of things that swops out things and trys to make things fast.



class ListView extends Backbone.View
    className: 'jmbo-list-view'
    tagName: 'ol'

    initialize: ->
        @collection.on 'reset', @render

    render: =>
        # jmbo-loading-view?
        @$el.html '<li>Loading...</li>'
        return this
        #pass


class ListItemView extends Backbone.View
    className: 'jmbo-list-item-view'
    tagName: 'li'

    initialize: ->
        # you can select a row.

    render: =>

        return this


exports = this
exports.Jmbo = exports.Jmbo ? {}
exports.Jmbo.ListView = ListView
