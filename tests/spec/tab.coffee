describe "TabView", ->
    #it
    tabView  = undefined
    testView = undefined
    beforeEach ->
        tabView = new Jmbo.TabView

        class TestView extends Backbone.View
                render: =>
                    @$el.html 'Pew.Pew.Pew.'
                    return this
        testView = new TestView()


    describe "Initialization", ->

        it "Creates an empty collection if one isn't provided", ->
            expect(tabView.collection).toBeDefined()
        
        it "Accepts a collection as a parameter", ->
            collection = new Backbone.Collection
            t = new Jmbo.TabView collection: collection
            expect(t.collection).toBe(collection)

    describe "Rendering", ->

        it "Updates the DOM when views are added.", ->
            $el = $('<div/>');
            $el.html tabView.render().el
            expect($el.find('.jmbo-bar-view li').length).toEqual(0)

            view_name = 'Test View'
            tabView.add view: testView, name: view_name
            expect($el.find('.jmbo-bar-view li').text()).toEqual(view_name)

        it "Updates the DOM when views are removed/ reset", ->
            $el = $('<div/>');
            $el.html tabView.render().el
            # add
            tabView.add view: testView
            expect($el.find('.jmbo-bar-view li').length).toEqual(1)
            # remove
            tabView.reset()
            expect($el.find('.jmbo-bar-view li').length).toEqual(0)
            # add
            tabView.add view: testView
            expect($el.find('.jmbo-bar-view li').length).toEqual(1)
            # remove
            tabView.removeAtIndex(0)
            expect($el.find('.jmbo-bar-view li').length).toEqual(0)

    describe "Tab Bar", ->

        it "Select view when element is clicked", ->

            $el = $('<div/>');
            $el.html tabView.render().el
            # add
            tabView.add view: testView
            expect($el.find('.jmbo-bar-view li').length).toEqual(1)
            $el.find('.jmbo-bar-view li').eq(0).click()

            expect(tabView.collection.at(0).get('selected')).toEqual(true)

        it "Render view in context when element is clicked", ->
            $el = $('<div/>');
            $el.html tabView.render().el
            tabView.add view: testView
            $el.find('.jmbo-bar-view li').eq(0).click()
            expect($el.find('.jmbo-tab-view-context').text()).toEqual(testView.$el.text())


        it "Not remove from context with `removeFromDOM` and clicked", ->
            $el = $('<div/>');
            $el.html tabView.render().el
            tabView.add view: testView

            class SecondView extends Backbone.View
                render: =>
                    @$el.html 'Pew2. Pew2. Pew2.'
                    return this
            secondView = new SecondView()

            tabView.add view: secondView, removeFromDOM: false
            $el.find('.jmbo-bar-view li').eq(0).click()
            expect($el.find('.jmbo-tab-view-context').text()).toEqual(testView.$el.text())

            $el.find('.jmbo-bar-view li').eq(1).click()

            


        it "Execute callback when `func` is specified", ->





