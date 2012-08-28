describe "StackView", ->
    #it
    stackView = undefined
    beforeEach ->
        stackView = new Jmbo.StackView 
            pushDefaults: {animation: false}
            popDefaults : {animation: false}, 


    describe "Initialization", ->
        
        it "Create an empty collection if one isn't provided", ->
            expect(stackView.collection).toBeDefined()

        it "Accept a collection as a parameter", ->
            collection = new Backbone.Collection
            s = new Jmbo.StackView collection: collection
            expect(s.collection).toBe(collection)

        it "Push/ Pop defaults shouldn't be overwritten", ->
            expect(stackView.options.pushDefaults.animation).toBe(false)

    describe "Pushing views", ->

        newView = undefined
        beforeEach ->
            class TestView extends Backbone.View
                render: =>
                    @$el.html 'Pew.Pew.Pew.'
                    return this
            newView = new TestView()

        it "Add it to the collection", ->
            stackView.push newView
            expect(stackView.collection.last().get 'view').toBe(newView)

        it "Render the view on `render()`", ->
            stackView.push newView
            expect(stackView.render().$el.find('div').eq(0).text()).toEqual(newView.$el.text())

        it "Not remove the previous view from DOM when `removeFromDOM` is false", ->
            # add existing view
            stackView.push newView

            # add another view
            class AnotherView extends Backbone.View
                render: =>
                    @$el.html 'Margle.'
                    return this

            anotherView = new AnotherView()
            stackView.push anotherView, removeFromDOM: false
            expect(stackView.collection.last().get 'view').toBe(anotherView)

            stackView.render()
            $divs = stackView.$el.find('div')
            expect($divs.length).toEqual(2)

            stackView.collection.each (sv, i) ->
                v = sv.get 'view'
                expect($divs.eq(i).text()).toEqual(v.$el.text())

        it "Executes animation callback", ->
            callback_push = jasmine.createSpy 'stack push'
            stackView.push new Backbone.View, callback: callback_push
            expect(callback_push).wasCalled()




    describe "Popping views", ->

        it "Remove a view from the collection", ->
            stackView.push new Backbone.View
            stackView.pop()
            expect(stackView.collection.length).toEqual(0)

        it "Execute animation callback", ->
            callback_pop = jasmine.createSpy 'stack pop'
            stackView.push new Backbone.View, callback: callback_pop
            expect(callback_pop).wasCalled()


    describe "Rendering", ->
        # pass

        it "Should even `render()` when the collection is empty", ->
            expect(stackView.collection.length).toEqual(0)
            $el = $ stackView.render().el
            expect($el.text()).toEqual('')


        it "Rerender when collection is reset", ->
            class TestView1 extends Backbone.View
                render: =>
                    @$el.html 'Pew.Pew.Pew.'
                    return this
            newView1 = new TestView1()

            stackView.push newView1
            expect(stackView.render().$el.find('div').eq(0).text()).toEqual(newView1.$el.text())


            class TestView2 extends Backbone.View
                render: =>
                    @$el.html 'Margle.'
                    return this
            newView2 = new TestView2()
            stackView.push newView2

            stackView.collection.reset new Backbone.Model(view: newView2)
            expect(stackView.$el.find('div').eq(0).text()).toEqual(newView2.$el.text())
