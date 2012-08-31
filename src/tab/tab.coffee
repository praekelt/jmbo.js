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
        @collection.on 'change:selected', @renderSelected

    render: =>
        @$el.contents().detach()

        @$context = $ '<div class="jmbo-tab-view-context"></div>'
        @$el.append @$context

        @barView = new BarView(collection: @collection)
        @$el.append @barView.render().el

        

        return this


    renderSelected: (model) =>
        console.log 'I am cheese'
        model = @collection.where('selected': true)[0]
        @$context.contents().detach()
        #@$context.append model.get('view').render().el

        

    selectedIndex: (index=0) =>
        for model in @collection.where('selected': true)
            do (model) ->
                @model.set 'selected': false
        @collection.at(selectedIndex).set 'selected': true


    # set
    # add
    # remove

class BarView extends Backbone.View
    tagName: 'ul'
    className: 'jmbo-bar-view'

    initialize: ->
        @collection.on 'add reset remove', @render

    render: =>
        console.log @collection
        @$el.html ''
        @collection.each (model) =>
            @$el.append new BarItemView(model: model).render().el
        return this


class BarItemView extends Backbone.View
    tagName: 'li'

    events: ->
        if 'ontouchstart' in document.documentElement 
            return 'touchstart': 'select'
        else
            return 'click': 'select'

    initialize: ->
        @model.on 'change:selected', @renderSelected

    render: =>
        @$el.html(@model.get('name')).addClass @model.get('icon')
        return this

    renderSelected: =>
        @$el.toggleClass 'selected'

    select: =>
        if @model.get('selected') is true then return
        for model in @model.collection.where(selected: true)
            do ->
                model.set selected: false
        @model.set selected: true
        



exports = this
exports.Jmbo = exports.Jmbo or {}
exports.Jmbo.TabView = TabView