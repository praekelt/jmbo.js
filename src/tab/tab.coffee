class TabViewVessel extends Backbone.Model
    defaults: 
        icon: ''
        name: 'Unnamed'
        view: undefined
class TabViewVessels extends Backbone.Collection
    model: TabViewVessel






class TabView extends Backbone.View
    # pass
    className: 'jmbo-tab-view'

    selectedIndex: 0

    initialize: ->
        if not @collection? then @collection = new TabViewVessels

    render: =>
        @$el.contents().detach()

        @$context = $ '<div class="jmbo-tab-view-context"></div>'
        @$el.append @$context

        @barView = new BarView(collection: @collection)
        @$el.append @barView.render().el

        @renderSelected()

        return this


    renderSelected: =>
        @$context.contents().detach()
        @$context.append "context"
        

    selectedIndex: (index=0) =>
        # margle


    # set
    # add
    # remove

class BarView extends Backbone.View
    tagName: 'ul'
    className: 'jmbo-bar-view'

    initialize: ->
        @collection.on 'add reset remove', @render

    render: =>
        console.log 'render'
        @$el.html ''
        @collection.each (barItem) =>
            @$el.append new BarItemView(model: barItem).render().el
        return this


class BarItemView extends Backbone.View
    tagName: 'li'

    render: =>

        @$el.html @model.get 
        return this



exports = this
exports.Jmbo = exports.Jmbo or {}
exports.Jmbo.TabView = TabView