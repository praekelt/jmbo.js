describe "StackView", ->
    #it
    stackView = undefined
    beforeEach ->
        stackView = new Jmbo.StackView

    describe "Initialization", ->
        it "Create an empty collection if one isn't provided", ->
            expect(stackView.collection).toBeDefined()

        it "Accept a collection as a parameter", ->
            collection = new Backbone.Collection
            s = new Jmbo.StackView collection: collection
            expect(s.collection).toBe(collection)

    describe "Pushing a view", ->

        newView = undefined
        beforeEach ->
            newView = new Backbone.View
            newView.$el.html '<b id="find-me">Find me</b>'

        it "Add it to the collection", ->
            stackView.push newView, animation: false
            expect(stackView.collection.last().get 'view').toBe(newView)

        it "Render that view on `render()`", ->
            stackView.push newView, animation: false
            expect(stackView.collection.last().get 'view').toBe(newView)
            stackView.render()
            # pass

        it "Not remove the previous view from DOM when `removeFromDOM` is false", ->
            # pass

        it "Execute animation callback", ->
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