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
      var vc = new jmbo.ui.view.ControllerView({view: new ChildView});
      stackController.push(vc, {animation: false});
      expect(stackController.collection.length).toEqual(1);

      var newstackController = new jmbo.ui.stack.ControllerView;
      expect(newstackController.collection.length).toEqual(0);
    });

    it("Add and remove views.", function() {
      expect(stackController.collection.length).toEqual(0);
      var vc1 = new jmbo.ui.view.ControllerView({view: new ChildView});
      var vc2 = new jmbo.ui.view.ControllerView({view: new ChildView});
      stackController.push(vc1, {animation: false});
      stackController.push(vc2, {animation: false});
      expect(stackController.collection.length).toEqual(2);

      popped_vc2 = stackController.pop({animation: false});
      expect(stackController.collection.length).toEqual(1);
      expect(popped_vc2).toBe(vc2);
    });

    it ("Only a `ControllerView` is an acceptable argument for `push`.", function() {
      // this will fail because the `animate` method can't be found.
      // TODO: make this test explicit, have a parameter in the controller view that 
      // identifies it.

        expect(function() {stackController.push(new ChildView, {animation: false})})
          .toThrow("Object [object Object] has no method 'animate'");
    });

    it("Remove views (and return undefined) when empty.", function() {
      expect(stackController.pop()).toBe(undefined);
    });

    it("DOM element not removed when cache is set to true on push", function() {
      expect(stackController.collection.length).toEqual(0);
      var vc1 = new jmbo.ui.view.ControllerView({view: new ChildView});
      stackController.push(vc1, {animation: false});
      expect(stackController.collection.length).toEqual(1);

      // the $el should still have a p element.
      expect(vc1.$el.find('p').length).toEqual(1);

      var vc2 = new jmbo.ui.view.ControllerView({view: new ChildView});
      stackController.push(vc2, {cache: true, animation:false});
      expect(stackController.collection.length).toEqual(2);
      expect(vc1.$el.find('p').length).toEqual(1);

      stackController.pop();
      expect(stackController.collection.length).toEqual(1);
      stackController.push(vc2, {animation:false});
      expect(vc1.$el.find('p').length).toEqual(0);
    });


    it("Should call the callback when animation is done.", function() {

      expect(stackController.collection.length).toEqual(0);
      var vc1 = new jmbo.ui.view.ControllerView({view: new ChildView});
      var callback_push = jasmine.createSpy('stack push');
      stackController.push(vc1, {animation: false, callback: callback_push});
      expect(callback_push).wasCalled();

      var callback_pop = jasmine.createSpy('stack pop');
      stackController.pop({animation: false, callback: callback_pop});
      expect(callback_pop).wasCalled();

      

    });

  });
});