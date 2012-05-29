var ChildView = Backbone.View.extend({
  render: function() {
    this.$el.html('<p>Child View.</p>');
    return this.el;
  }
});

describe("ui.tab", function() {
  
  var tabController;
  beforeEach(function() {
    tabController = new jmbo.ui.tab.ControllerView;
  });

  describe("ControllerView", function() {

    it("Collection should initially be empty.", function() {
      expect(tabController.collection.isEmpty()).toBe(true);
      var vc = new jmbo.ui.view.ControllerView({childView: new ChildView});
      tabController.set(vc);
      expect(tabController.collection.length).toEqual(1);

      var newTabController = new jmbo.ui.tab.ControllerView;
      expect(newTabController.collection.isEmpty()).toBe(true)
    });

    it("Set and empty the `Controllers` collection.", function() {

      expect(tabController.collection.isEmpty()).toBe(true)
      var vc1 = new jmbo.ui.view.ControllerView({childView: new ChildView});
      var vc2 = new jmbo.ui.view.ControllerView({childView: new ChildView});
      tabController.set(vc1, vc2);
      expect(tabController.collection.length).toEqual(2);

      tabController.set();
      expect(tabController.collection.isEmpty()).toBe(true)
    });


    it("Set and get the selectedIndex", function() {

      var vc1 = new jmbo.ui.view.ControllerView({childView: new ChildView});
      var vc2 = new jmbo.ui.view.ControllerView({childView: new ChildView});
      tabController.set(vc1, vc2);
      expect(tabController.selectedIndex()).toEqual(0);

      tabController.selectedIndex(1);
      expect(tabController.selectedIndex()).toEqual(1);
    });
  });

  describe("BarView", function() {

    it("Number if `li` elements should be the same as collection's length.", function() {

      var vc1 = new jmbo.ui.view.ControllerView({childView: new ChildView});
      var vc2 = new jmbo.ui.view.ControllerView({childView: new ChildView});
      tabController.set(vc1, vc2);
      
      var barView = new jmbo.ui.tab._BarView({
        collection: tabController.collection
      });
      barView.render()
      expect(barView.$el.find('li').length).toEqual(2)
    });

  });

  describe ("BarItemView", function() {

    it("Title of item should be the same as in the `config` model.", function() {

      var vc1 = new jmbo.ui.view.ControllerView({
        childView: new ChildView, 
        title: 'Test.'
      });
      var vc2 = new jmbo.ui.view.ControllerView({childView: new ChildView});
      tabController.set(vc1, vc2);

      var barItemView = new jmbo.ui.tab._BarItemView({
        model: tabController.collection.at(0)
      });
      barItemView.render()

      expect(barItemView.$el.text()).toEqual(vc1.config.get('title'));
    });

  });
});