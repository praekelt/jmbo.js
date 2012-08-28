// Generated by CoffeeScript 1.3.3
(function() {
  var BarItemView, BarView, ControllerView,
    __bind = function(fn, me){ return function(){ return fn.apply(me, arguments); }; },
    __hasProp = {}.hasOwnProperty,
    __extends = function(child, parent) { for (var key in parent) { if (__hasProp.call(parent, key)) child[key] = parent[key]; } function ctor() { this.constructor = child; } ctor.prototype = parent.prototype; child.prototype = new ctor(); child.__super__ = parent.prototype; return child; },
    __slice = [].slice;

  BarItemView = (function(_super) {

    __extends(BarItemView, _super);

    function BarItemView() {
      this.renderSelected = __bind(this.renderSelected, this);

      this.render = __bind(this.render, this);

      this.select = __bind(this.select, this);
      return BarItemView.__super__.constructor.apply(this, arguments);
    }

    BarItemView.prototype.tagName = 'li';

    BarItemView.prototype.className = 'jmbo-ui-tab-bar-item-view';

    BarItemView.prototype.events = {
      'touchstart': 'select'
    };

    BarItemView.prototype.initialize = function() {
      return this.model.on('change:selected', this.renderSelected);
    };

    BarItemView.prototype.select = function(e) {
      var controller, _fn, _i, _len, _ref;
      if (this.model.get('selected') === true) {
        return;
      }
      _ref = this.model.collection.where({
        selected: true
      });
      _fn = function() {
        return controller.set({
          selected: false
        });
      };
      for (_i = 0, _len = _ref.length; _i < _len; _i++) {
        controller = _ref[_i];
        _fn();
      }
      return this.model.set({
        selected: true
      });
    };

    BarItemView.prototype.render = function() {
      var controllerViewConfig, icon;
      controllerViewConfig = this.model.get('view').config;
      this.$el.html(controllerViewConfig.get('title'));
      icon = controllerViewConfig.get('icon');
      if (icon != null) {
        this.$el.append("<div class=\"icon-" + icon + "\"></div>");
      }
      return this.el;
    };

    BarItemView.prototype.renderSelected = function() {
      return this.$el.toggleClass('selected');
    };

    return BarItemView;

  })(Backbone.View);

  BarView = (function(_super) {

    __extends(BarView, _super);

    function BarView() {
      this.render = __bind(this.render, this);
      return BarView.__super__.constructor.apply(this, arguments);
    }

    BarView.prototype.tagName = 'ul';

    BarView.prototype.className = 'jmbo-ui-tab-bar-view';

    BarView.prototype.initialize = function() {
      return this.collection.on('reset', this.render);
    };

    BarView.prototype.render = function() {
      var that;
      this.$el.html('');
      that = this;
      this.collection.each(function(model) {
        return that.$el.append(new BarItemView({
          model: model
        }).render());
      });
      return this.el;
    };

    return BarView;

  })(Backbone.View);

  ControllerView = (function(_super) {

    __extends(ControllerView, _super);

    function ControllerView() {
      this.selectedIndex = __bind(this.selectedIndex, this);

      this.set = __bind(this.set, this);

      this.renderSelected = __bind(this.renderSelected, this);

      this.render = __bind(this.render, this);
      return ControllerView.__super__.constructor.apply(this, arguments);
    }

    ControllerView.prototype.className = 'jmbo-ui-tab-controller-view';

    ControllerView.prototype.initialize = function() {
      ControllerView.__super__.initialize.apply(this, arguments);
      this.collection = new jmbo.ui.view.Controllers;
      this.collection.on('change:selected', this.renderSelected);
      return this._selectedIndex = 0;
    };

    ControllerView.prototype.render = function() {
      var bar;
      this.$el.html('<div id="jmbo-ui-tab-controller-view-context"></div>');
      bar = new BarView({
        collection: this.collection
      });
      this.$el.append(bar.render());
      return this.el;
    };

    ControllerView.prototype.renderSelected = function() {
      var controllerView, controllers;
      controllers = this.collection.where({
        selected: true
      });
      if (controllers.length) {
        controllerView = controllers[0].get('view');
        if (controllerView != null) {
          this.$el.find('#jmbo-ui-tab-controller-view-context').html(controllerView.render());
          return controllerView.firePostRenderEvent();
        }
      }
    };

    ControllerView.prototype.set = function() {
      var controllerViews, that, view, _fn, _i, _len;
      controllerViews = 1 <= arguments.length ? __slice.call(arguments, 0) : [];
      this.collection.reset([], {
        silent: true
      });
      if (controllerViews.length === 0) {
        this.collection.trigger('reset');
        return;
      }
      that = this;
      _fn = function() {
        return that.collection.add({
          view: view,
          selected: false
        }, {
          silent: true
        });
      };
      for (_i = 0, _len = controllerViews.length; _i < _len; _i++) {
        view = controllerViews[_i];
        _fn();
      }
      this.collection.trigger('reset');
      return this.selectedIndex(0);
    };

    ControllerView.prototype.selectedIndex = function(i) {
      var controller, _fn, _i, _len, _ref;
      if (!(i != null)) {
        return i = this._selectedIndex;
      }
      _ref = this.collection.where({
        selected: true
      });
      _fn = function() {
        return controller.set({
          selected: false
        });
      };
      for (_i = 0, _len = _ref.length; _i < _len; _i++) {
        controller = _ref[_i];
        _fn();
      }
      this.collection.at(i).set({
        selected: true
      });
      return this._selectedIndex = i;
    };

    return ControllerView;

  })(jmbo.ui.view.ControllerView);

  namespace('jmbo.ui.tab', function(exports) {
    exports.ControllerView = ControllerView;
    exports._BarView = BarView;
    return exports._BarItemView = BarItemView;
  });

}).call(this);