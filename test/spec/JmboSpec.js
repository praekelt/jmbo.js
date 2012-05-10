var ChildView = Backbone.View.extend({
  render: function() {
    return this.el
  }
});



describe("View", function() {

  describe("Controller View", function() {
    it("Return false on render() if a model or model.childView are not set.", function() {
      // test failure.
      var vcView = new jmbo.view._ControllerView();
      expect(vcView.render()).toEqual(false);
      expect(vcView.model).toBeUndefined();

      // create a childView, and view controller.
      var cv = new ChildView;
      var vc = new jmbo.view.Controller({childView: cv});
      vcView.model = vc;
      // render should return an div element
      expect($(vcView.render()).hasClass(vcView.className)).toEqual(true);
    });
  });

  describe("Navigation Controller View", function() {
    var navController;

    beforeEach(function() {
      navController = new jmbo.view.NavigationControllerView
    });

    it ("Begin with an empty collection of ViewControllers", function() {
      expect(navController.collection.length).toEqual(0);

      // add a view controller
      var cv = new ChildView;
      var vc = new jmbo.view.Controller({childView: cv});
      navController.push(vc);

      // re initialize the navigation controller;
      navController = new jmbo.view.NavigationControllerView

      // should be empty.
      expect(navController.collection.length).toEqual(0);

    });

    it ("Add a view controller.", function() {
      var cv1 = new ChildView;
      var vc1 = new jmbo.view.Controller({childView: cv1});
      navController.push(vc1);
      expect(navController.collection.length).toEqual(1);

      var cv2 = new ChildView;
      var vc2 = new jmbo.view.Controller({childView: cv2});
      navController.push(vc2);
      expect(navController.collection.length).toEqual(2);
    });

    it ("Remove a view controller.", function() {

      var cv = new ChildView;
      var vc = new jmbo.view.Controller({childView: cv});
      navController.push(vc);
      expect(navController.collection.length).toEqual(1);

      vc_popped = navController.pop();
      expect(vc_popped).toBe(vc);
      expect(navController.collection.length).toEqual(0);


    });

    it ("Return null if trying to pop from empty collection.", function() {
      var cv = new ChildView;
      var vc = new jmbo.view.Controller({childView: cv});
      navController.push(vc);
      expect(navController.collection.length).toEqual(1);

      vc_popped = navController.pop();
      expect(vc_popped).toBe(vc);
      expect(navController.collection.length).toEqual(0);

      vc_popped = navController.pop();
      expect(vc_popped).toEqual(null);
    });

  });


});




