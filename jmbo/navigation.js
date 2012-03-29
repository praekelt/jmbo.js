(function() {
  var NavigationController, TitleView, ViewController, ViewControllerView, ViewControllers,
    __bind = function(fn, me){ return function(){ return fn.apply(me, arguments); }; },
    __hasProp = Object.prototype.hasOwnProperty,
    __extends = function(child, parent) { for (var key in parent) { if (__hasProp.call(parent, key)) child[key] = parent[key]; } function ctor() { this.constructor = child; } ctor.prototype = parent.prototype; child.prototype = new ctor; child.__super__ = parent.prototype; return child; };

  TitleView = (function(_super) {

    __extends(TitleView, _super);

    function TitleView() {
      this.setTitle = __bind(this.setTitle, this);
      this.render = __bind(this.render, this);
      TitleView.__super__.constructor.apply(this, arguments);
    }

    TitleView.prototype.className = 'jmbo-title-view';

    TitleView.prototype.initialize = function() {
      this.template = _.template('<h1><%= title %></h1>');
      return this.title = 'Untitled';
    };

    TitleView.prototype.render = function() {
      return this.$el.html(this.template({
        title: this.title
      }));
    };

    TitleView.prototype.setTitle = function(title) {
      return this.title = title;
    };

    return TitleView;

  })(Backbone.View);

  ViewController = (function(_super) {

    __extends(ViewController, _super);

    function ViewController() {
      ViewController.__super__.constructor.apply(this, arguments);
    }

    ViewController.prototype.defaults = {
      container: null,
      cacheView: false,
      titleView: TitleView,
      childView: null,
      animation: 'slide',
      title: ''
    };

    return ViewController;

  })(Backbone.Model);

  ViewControllers = (function(_super) {

    __extends(ViewControllers, _super);

    function ViewControllers() {
      ViewControllers.__super__.constructor.apply(this, arguments);
    }

    ViewControllers.prototype.model = ViewController;

    return ViewControllers;

  })(Backbone.Collection);

  ViewControllerView = (function(_super) {

    __extends(ViewControllerView, _super);

    function ViewControllerView() {
      this.animate = __bind(this.animate, this);
      this.render = __bind(this.render, this);
      ViewControllerView.__super__.constructor.apply(this, arguments);
    }

    ViewControllerView.prototype.className = 'jmbo-view-controller-view';

    ViewControllerView.prototype.render = function() {
      var childView, titleView;
      titleView = new (this.model.get('titleView'));
      titleView.setTitle(this.model.get('title'));
      this.$el.append(titleView.render());
      childView = this.model.get('childView');
      this.$el.append(this.model.get('childView').render());
      return this.el;
    };

    ViewControllerView.prototype.animate = function(name, callback) {
      return jmbo.view.animate(this.$el, name, callback);
    };

    return ViewControllerView;

  })(Backbone.View);

  NavigationController = (function(_super) {

    __extends(NavigationController, _super);

    function NavigationController() {
      this.pushViewController = __bind(this.pushViewController, this);
      this.popViewController = __bind(this.popViewController, this);
      this.render = __bind(this.render, this);
      NavigationController.__super__.constructor.apply(this, arguments);
    }

    NavigationController.prototype.className = 'jmbo-navigation-controller';

    NavigationController.prototype.initialize = function() {
      return this.viewControllers = new ViewControllers;
    };

    NavigationController.prototype.render = function() {
      this.$el.html('');
      return this.el;
    };

    NavigationController.prototype.popViewController = function() {
      var activeVC, activeVC_View, viewController, viewControllerView;
      activeVC = this.viewControllers.pop();
      activeVC_View = activeVC.get('container');
      activeVC_View.animate('slide-right-out', function() {
        activeVC_View.$el.html('').remove();
        return delete activeVC;
      });
      if (this.viewControllers.length > 0) {
        viewController = this.viewControllers.last();
        viewControllerView = new ViewControllerView({
          model: viewController
        });
        viewController.set({
          container: viewControllerView
        });
        this.$el.prepend(viewControllerView.render());
        return viewControllerView.animate('slide-left-in');
      }
    };

    NavigationController.prototype.pushViewController = function(viewController) {
      var activeVC, activeVC_View, vcView;
      if (this.viewControllers.length > 0) {
        activeVC = this.viewControllers.last();
        activeVC_View = activeVC.get('container');
        activeVC_View.animate('slide-left-out', function() {
          activeVC_View.$el.remove();
          return activeVC.unset('container');
        });
      }
      this.viewControllers.add(viewController);
      vcView = new ViewControllerView({
        model: viewController
      });
      viewController.set({
        container: vcView
      });
      this.$el.append(vcView.render());
      vcView.animate('slide-right-in');
      return viewController;
    };

    return NavigationController;

  })(Backbone.View);

  namespace('jmbo.view', function(exports) {
    exports.Controller = ViewController;
    exports.TitleView = TitleView;
    return exports.animate = function($el, className, callback) {
      $el.addClass(className);
      return $el.on('webkitAnimationEnd', function() {
        $el.removeClass(className).off('webkitAnimationEnd');
        if (callback) return callback();
      });
    };
  });

  namespace('jmbo.navigation', function(exports) {
    return exports.Controller = NavigationController;
  });

}).call(this);
