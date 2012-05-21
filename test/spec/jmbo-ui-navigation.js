var ChildView = Backbone.View.extend({
  render: function() {
    this.$el.html('<p>Child View.</p>');
    return this.el;
  }
});

describe("ui.navigation", function() {
  
  var navController;
  beforeEach(function() {
    navController = new jmbo.ui.navigation.ControllerView;
  });

  describe("ControllerView", function() {

    it("Collection should initially be empty.", function() {
      expect(navController.collection.length).toEqual(0);
      var vc = new jmbo.ui.view.ControllerView({childView: new ChildView});
      navController.push(vc, {animation: 'none'});
      expect(navController.collection.length).toEqual(1);

      var newNavController = new jmbo.ui.navigation.ControllerView;
      expect(newNavController.collection.length).toEqual(0);
    });

    it("Add and remove views.", function() {
      expect(navController.collection.length).toEqual(0);
      var vc1 = new jmbo.ui.view.ControllerView({childView: new ChildView});
      var vc2 = new jmbo.ui.view.ControllerView({childView: new ChildView});
      navController.push(vc1, {animation: 'none'});
      navController.push(vc2, {animation: 'none'});
      expect(navController.collection.length).toEqual(2);

      popped_vc2 = navController.pop({animation: 'none'});
      expect(navController.collection.length).toEqual(1);
      expect(popped_vc2).toBe(vc2);
    });

    it ("Only a `ControllerView` is an acceptable argument for `push`.", function() {
      // this will fail because the `animate` method can't be found.
        expect(function() {navController.push(new ChildView, {animation: 'none'})})
          .toThrow("Object [object Object] has no method 'animate'");
    });

    it ("Remove views (and return undefined) when empty.", function() {
      expect(navController.pop()).toBe(undefined);
    });
  });
});