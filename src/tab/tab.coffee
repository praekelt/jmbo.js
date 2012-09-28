class TabViewVessel extends Backbone.Model
    defaults: 
        icon: ''
        name: 'Unnamed'
        view: undefined
        removeFromDOM: true
        func: undefined
class TabViewVessels extends Backbone.Collection
    model: TabViewVessel


class TabView extends Backbone.View
    className: 'jmbo-tab-view'

    initialize: ->
        if not @collection? then @collection = new TabViewVessels
        @collection.on 'change:selected', @renderSelected

    render: =>
        @$el.contents().detach()

        @$context = $ '<div class="jmbo-tab-view-context"></div>'
        @$el.append @$context

        @barView = new BarView(collection: @collection)
        @$el.append @barView.render().el

        selectedView = @collection.where('selected': true)[0]
        if selectedView? then @renderSelected(selectedView)

        return this

    renderSelected: (model) =>
        if not model.get('selected') 
            model.get('view')?.trigger 'tab:blur'
            return

        # does this tab have a function to execute?
        model.get('func')?()

        if model.get('removeFromDOM') then @$context.contents().detach()
        view = model.get 'view'
        if view?
            @$context.append view.render().el
            view.trigger 'tab:focus'

    add: (obj) =>
        @collection.add obj

    reset: (objs...) =>
        @collection.reset objs

    removeAtIndex: (i) => 
        @collection.remove @collection.at(i)

    selectAtIndex: (i) =>
        @collection.where(selected: true)[0]?.set selected: false
        @collection.at(i).set 'selected': true


class BarView extends Backbone.View
    tagName: 'ul'
    className: 'jmbo-tab-bar-view'

    initialize: ->
        @collection.on 'add reset remove', @render

    render: =>
        @$el.html ''
        @collection.each (model) =>
            @$el.append new BarItemView(model: model).render().el
        return this


class BarItemView extends Backbone.View
    tagName: 'li'

    initialize: ->
        @model.on 'change:selected', @renderSelected
        @$el.on 'click', @select

    render: =>
        @$el.html(@model.get('name')).addClass @model.get('icon')
        if @model.get 'selected' then @renderSelected()
        return this

    renderSelected: =>
        @$el.toggleClass 'selected'

    select: =>
        @model.collection.where(selected: true)[0]?.set selected: false
        @model.set selected: true
        



exports = this
exports.Jmbo = exports.Jmbo or {}
exports.Jmbo.TabView = TabView