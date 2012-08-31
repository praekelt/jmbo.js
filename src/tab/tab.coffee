class TabViewVessel extends Backbone.Model
class TabViewVessels extends Backbone.Collection
    model: TabViewVessels






class TabView extends Backbone.View
    # pass
    className: 'jmbo-tab-view'

    selectedIndex: 0

    initialize: ->
        # takes a collection, or you create a collection.

        # options 
            # 

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



class BarView extends Backbone.View
    tagName: 'ul'
    className: '.jmbo-bar-view'


    render: =>
        @$el.html 'bar'
        return this


class BarItemView extends Backbone.View
    tagName: 'li'

    render: =>
        @$el.html 'saodksaopdksa'
        return this



exports = this
exports.Jmbo = exports.Jmbo or {}
exports.Jmbo.TabView = TabView