var ChildView = Backbone.View.extend({
  render: function() {
    this.$el.html('<p>Child View.</p>');
    return this.el;
  }
});

describe("ui.stack", function() {
  
  var stackController;
  beforeEach(function() {
    stackController = new jmbo.ui.stack.ControllerView;
  });

  describe("ControllerView", function() {

    it("Collection should initially be empty.", function() {
      expect(stackController.collection.length).toEqual(0);
      var vc = new jmbo.ui.view.ControllerView({childView: new ChildView});
      stackController.push(vc, {animation: 'none'});
      expect(stackController.collection.length).toEqual(1);

      var newstackController = new jmbo.ui.stack.ControllerView;
      expect(newstackController.collection.length).toEqual(0);
    });

    it("Add and remove views.", function() {
      expect(stackController.collection.length).toEqual(0);
      var vc1 = new jmbo.ui.view.ControllerView({childView: new ChildView});
      var vc2 = new jmbo.ui.view.ControllerView({childView: new ChildView});
      stackController.push(vc1, {animation: 'none'});
      stackController.push(vc2, {animation: 'none'});
      expect(stackController.collection.length).toEqual(2);

      popped_vc2 = stackController.pop({animation: 'none'});
      expect(stackController.collection.length).toEqual(1);
      expect(popped_vc2).toBe(vc2);
    });

    it ("Only a `ControllerView` is an acceptable argument for `push`.", function() {
      // this will fail because the `animate` method can't be found.
        expect(function() {stackController.push(new ChildView, {animation: false})})
          .toThrow("Object [object Object] has no method 'animate'");
    });

    it ("Remove views (and return undefined) when empty.", function() {
      expect(stackController.pop()).toBe(undefined);
    });

    it("transition animation ended should always fire. ", function() {
      expect(true).toBe(false)
    });

  });
});