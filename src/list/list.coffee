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
                @$el.append new ListItemView(
                    model: item, 
                    template: @options.itemTemplate
                    select: @options.itemSelect
                ).render().el

        return this


class ListItemView extends Backbone.View
    className: 'jmbo-list-item-view'
    tagName: 'li'
    template: _.template """<%= item.title %>"""

    events:
        'click': 'select'

    initialize: ->
        if @options.template? then @template = _.template @options.template

    render: =>
        @$el.html @template item: @model.toJSON()
        return this

    select: =>
        @options.select?(@model)


exports = this
exports.Jmbo = exports.Jmbo ? {}
exports.Jmbo.ListView = ListView
