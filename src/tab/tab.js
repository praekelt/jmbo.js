// Generated by CoffeeScript 1.3.3
(function() {
  var BarItemView, BarView, TabView, TabViewVessel, TabViewVessels, exports,
    __hasProp = {}.hasOwnProperty,
    __extends = function(child, parent) { for (var key in parent) { if (__hasProp.call(parent, key)) child[key] = parent[key]; } function ctor() { this.constructor = child; } ctor.prototype = parent.prototype; child.prototype = new ctor(); child.__super__ = parent.prototype; return child; },
    __bind = function(fn, me){ return function(){ return fn.apply(me, arguments); }; },
    __indexOf = [].indexOf || function(item) { for (var i = 0, l = this.length; i < l; i++) { if (i in this && this[i] === item) return i; } return -1; };

  TabViewVessel = (function(_super) {

    __extends(TabViewVessel, _super);

    function TabViewVessel() {
      return TabViewVessel.__super__.constructor.apply(this, arguments);
    }

    TabViewVessel.prototype.defaults = {
      icon: '',
      name: 'Unnamed',
      view: void 0
    };

    return TabViewVessel;

  })(Backbone.Model);

  TabViewVessels = (function(_super) {

    __extends(TabViewVessels, _super);

    function TabViewVessels() {
      return TabViewVessels.__super__.constructor.apply(this, arguments);
    }

    TabViewVessels.prototype.model = TabViewVessel;

    return TabViewVessels;

  })(Backbone.Collection);

  TabView = (function(_super) {

    __extends(TabView, _super);

    function TabView() {
      this.selectedIndex = __bind(this.selectedIndex, this);

      this.renderSelected = __bind(this.renderSelected, this);

      this.render = __bind(this.render, this);
      return TabView.__super__.constructor.apply(this, arguments);
    }

    TabView.prototype.className = 'jmbo-tab-view';

    TabView.prototype.selectedIndex = 0;

    TabView.prototype.initialize = function() {
      if (!(this.collection != null)) {
        this.collection = new TabViewVessels;
      }
      return this.collection.on('change:selected', this.renderSelected);
    };

    TabView.prototype.render = function() {
      this.$el.contents().detach();
      this.$context = $('<div class="jmbo-tab-view-context"></div>');
      this.$el.append(this.$context);
      this.barView = new BarView({
        collection: this.collection
      });
      this.$el.append(this.barView.render().el);
      return this;
    };

    TabView.prototype.renderSelected = function(model) {
      console.log('I am cheese');
      model = this.collection.where({
        'selected': true
      })[0];
      return this.$context.contents().detach();
    };

    TabView.prototype.selectedIndex = function(index) {
      var model, _fn, _i, _len, _ref;
      if (index == null) {
        index = 0;
      }
      _ref = this.collection.where({
        'selected': true
      });
      _fn = function(model) {
        return this.model.set({
          'selected': false
        });
      };
      for (_i = 0, _len = _ref.length; _i < _len; _i++) {
        model = _ref[_i];
        _fn(model);
      }
      return this.collection.at(selectedIndex).set({
        'selected': true
      });
    };

    return TabView;

  })(Backbone.View);

  BarView = (function(_super) {

    __extends(BarView, _super);

    function BarView() {
      this.render = __bind(this.render, this);
      return BarView.__super__.constructor.apply(this, arguments);
    }

    BarView.prototype.tagName = 'ul';

    BarView.prototype.className = 'jmbo-bar-view';

    BarView.prototype.initialize = function() {
      return this.collection.on('add reset remove', this.render);
    };

    BarView.prototype.render = function() {
      var _this = this;
      console.log(this.collection);
      this.$el.html('');
      this.collection.each(function(model) {
        return _this.$el.append(new BarItemView({
          model: model
        }).render().el);
      });
      return this;
    };

    return BarView;

  })(Backbone.View);

  BarItemView = (function(_super) {

    __extends(BarItemView, _super);

    function BarItemView() {
      this.select = __bind(this.select, this);

      this.renderSelected = __bind(this.renderSelected, this);

      this.render = __bind(this.render, this);
      return BarItemView.__super__.constructor.apply(this, arguments);
    }

    BarItemView.prototype.tagName = 'li';

    BarItemView.prototype.events = function() {
      if (__indexOf.call(document.documentElement, 'ontouchstart') >= 0) {
        return {
          'touchstart': 'select'
        };
      } else {
        return {
          'click': 'select'
        };
      }
    };

    BarItemView.prototype.initialize = function() {
      return this.model.on('change:selected', this.renderSelected);
    };

    BarItemView.prototype.render = function() {
      this.$el.html(this.model.get('name')).addClass(this.model.get('icon'));
      return this;
    };

    BarItemView.prototype.renderSelected = function() {
      return this.$el.toggleClass('selected');
    };

    BarItemView.prototype.select = function() {
      var model, _fn, _i, _len, _ref;
      if (this.model.get('selected') === true) {
        return;
      }
      _ref = this.model.collection.where({
        selected: true
      });
      _fn = function() {
        return model.set({
          selected: false
        });
      };
      for (_i = 0, _len = _ref.length; _i < _len; _i++) {
        model = _ref[_i];
        _fn();
      }
      return this.model.set({
        selected: true
      });
    };

    return BarItemView;

  })(Backbone.View);

  exports = this;

  exports.Jmbo = exports.Jmbo || {};

  exports.Jmbo.TabView = TabView;

}).call(this);