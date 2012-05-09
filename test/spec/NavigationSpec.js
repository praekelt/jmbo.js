var ChildView = Backbone.View.extend({
  render: function() {
    return this.el
  }
});



describe("View", function() {

  describe("Controller View", function() {
    it(" should return false on render() if a model and model.childView are not set.", function() {
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
});




describe("Navigation", function() {
  

  describe("Stack Controller View", function() {
    var stackControllerView;

    beforeEach(function() {
      stackControllerView = new jmbo.navigation.StackControllerView
    });

    it ("should begin with an empty collection of ViewControllers", function() {
      expect(stackControllerView.collection.length).toEqual(0);

      // add a view controller
      var cv = new ChildView;
      var vc = new jmbo.view.Controller({childView: cv});
      stackControllerView.push(vc);

      // re initialize the navigation controller;
      stackControllerView = new jmbo.navigation.StackControllerView

      // should be empty.
      expect(stackControllerView.collection.length).toEqual(0);

    });

    it ("should be able to add a view controller.", function() {
      var cv1 = new ChildView;
      var vc1 = new jmbo.view.Controller({childView: cv1});
      stackControllerView.push(vc1);
      expect(stackControllerView.collection.length).toEqual(1);

      var cv2 = new ChildView;
      var vc2 = new jmbo.view.Controller({childView: cv2});
      stackControllerView.push(vc2);
      expect(stackControllerView.collection.length).toEqual(2);
    });

    it ("should be able to remove a view controller.", function() {

      var cv = new ChildView;
      var vc = new jmbo.view.Controller({childView: cv});
      stackControllerView.push(vc);
      expect(stackControllerView.collection.length).toEqual(1);

      vc_popped = stackControllerView.pop();
      expect(vc_popped).toBe(vc);
      expect(stackControllerView.collection.length).toEqual(0);


    });

    it ("shouldn't return null if trying to pop from empty collection.", function() {
      var cv = new ChildView;
      var vc = new jmbo.view.Controller({childView: cv});
      stackControllerView.push(vc);
      expect(stackControllerView.collection.length).toEqual(1);

      vc_popped = stackControllerView.pop();
      expect(vc_popped).toBe(vc);
      expect(stackControllerView.collection.length).toEqual(0);

      vc_popped = stackControllerView.pop();
      expect(vc_popped).toEqual(null);
    });

  });
});