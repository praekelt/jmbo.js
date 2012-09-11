# so this is the big one...

# a list of things that swops out things and trys to make things fast.



class ListView extends Backbone.View
    className: 'jmbo-list-view'
    tagName: 'ol'

    initialize: ->
        @collection.on 'reset', @render

    render: =>
        @$el.html ''
        if @collection.length == 0
            @$el.html '<li class="loading">Loading...</li>'
        else
            # loop through rows
            @collection.each (item, index) =>
                @$el.append new ListItemView(model: item).render().el

                console.log item


        return this


class ListItemView extends Backbone.View
    className: 'jmbo-list-item-view'
    tagName: 'li'

    initialize: ->
        # you can select a row.

    render: =>
        @$el.html 'dsadas'
        return this


exports = this
exports.Jmbo = exports.Jmbo ? {}
exports.Jmbo.ListView = ListView
