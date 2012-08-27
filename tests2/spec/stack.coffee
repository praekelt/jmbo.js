describe "StackView", ->
    #it
    stackView = undefined
    beforeEach ->
        stackView = new Jmbo.StackView 
            pushDefaults: {animation: false}
            popDefaults: {animation: false}, 


    describe "Initialization", ->
        
        it "Create an empty collection if one isn't provided", ->
            expect(stackView.collection).toBeDefined()

        it "Accept a collection as a parameter", ->
            collection = new Backbone.Collection
            s = new Jmbo.StackView collection: collection
            expect(s.collection).toBe(collection)

        it "Push/ Pop defaults shouldn't be overwritten", ->
            expect(stackView.options.pushDefaults.animation).toBe(false)

    describe "Pushing a view", ->

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

        it "Render that view on `render()`", ->
            stackView.push newView
            expect(stackView.render().$el.find('div').eq(0).text()).toEqual(newView.$el.text())

        it "Not remove the previous view from DOM when `removeViewFromDOM` is false", ->
            # add existing view
            stackView.push newView

            # add another view
            class AnotherView extends Backbone.View
                render: =>
                    @$el.html 'Margle.'
                    return this

            anotherView = new AnotherView()
            stackView.push anotherView, removeViewFromDOM: false
            expect(stackView.collection.last().get 'view').toBe(anotherView)

            stackView.render()
            $divs = stackView.$el.find('div')
            expect($divs.length).toEqual(2)

            stackView.collection.each (sv, i) ->
                v = sv.get 'view'
                expect($divs.eq(i).text()).toEqual(v.$el.text())

        it "Executes animation in callback", ->
            # pass

        it "Executes animation out callback", ->
            # pass




    describe "Popping views", ->

        it "Remove a view from the collection", ->
            # pass

        it "Execute animation callback", ->
            # pass


    describe "Rendering", ->
        # pass

        it "Shouldn't render when the collection is empty", ->
            # pass

        it "Rerender when collection is reset", ->
            # pass

        it "Render the last view in the collection", ->








# describe('stack.js', function() {

#     describe('StackView', function() {

#     describe('StackView', function() {
#         it("each notch in namespace should be assigned or created", function() {
#         });
#     });
# });