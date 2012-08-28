// Generated by CoffeeScript 1.3.3
(function() {
  var Config, Controller, ControllerView, Controllers,
    __hasProp = {}.hasOwnProperty,
    __extends = function(child, parent) { for (var key in parent) { if (__hasProp.call(parent, key)) child[key] = parent[key]; } function ctor() { this.constructor = child; } ctor.prototype = parent.prototype; child.prototype = new ctor(); child.__super__ = parent.prototype; return child; },
    __bind = function(fn, me){ return function(){ return fn.apply(me, arguments); }; };

  Controller = (function(_super) {

    __extends(Controller, _super);

    function Controller() {
      return Controller.__super__.constructor.apply(this, arguments);
    }

    Controller.prototype.defaults = {
      view: void 0
    };

    return Controller;

  })(Backbone.Model);

  Controllers = (function(_super) {

    __extends(Controllers, _super);

    function Controllers() {
      return Controllers.__super__.constructor.apply(this, arguments);
    }

    Controllers.prototype.model = Controller;

    return Controllers;

  })(Backbone.Collection);

  Config = (function(_super) {

    __extends(Config, _super);

    function Config() {
      return Config.__super__.constructor.apply(this, arguments);
    }

    Config.prototype.defaults = {
      TitleView: jmbo.ui.TitleView,
      view: void 0,
      title: 'Untitled',
      icon: void 0
    };

    return Config;

  })(Backbone.Model);

  ControllerView = (function(_super) {

    __extends(ControllerView, _super);

    function ControllerView() {
      this.animate = __bind(this.animate, this);

      this.firePostRenderEvent = __bind(this.firePostRenderEvent, this);

      this.render = __bind(this.render, this);
      return ControllerView.__super__.constructor.apply(this, arguments);
    }

    ControllerView.prototype.className = 'jmbo-ui-view-controller-view';

    ControllerView.prototype.initialize = function() {
      var view;
      this.config = new Config(this.options);
      view = this.config.get('view');
      if (view != null) {
        return view.controller = this;
      }
    };

    ControllerView.prototype.render = function() {
      var TitleView, view, viewEl;
      this.$el.html('');
      TitleView = this.config.get('TitleView');
      if (TitleView != null) {
        if (!(this.titleView != null)) {
          this.titleView = new TitleView();
        }
        this.$el.html(this.titleView.render());
        this.titleView.setTitle(this.config.get('title'));
      }
      view = this.config.get('view');
      if (view != null) {
        if (view.render != null) {
          viewEl = view.render();
        } else {
          viewEl = $(view).html();
        }
        $(viewEl).addClass('jmbo-ui-view-controller-view-view');
        this.$el.append(viewEl);
      }
      return this.el;
    };

    ControllerView.prototype.firePostRenderEvent = function() {
      var view;
      view = this.config.get('view');
      if (view != null) {
        view.delegateEvents();
        return view.trigger('render:post');
      }
    };

    ControllerView.prototype.animate = function(name, direction, callback) {
      return jmbo.ui.animate(this.$el, name, direction, callback);
    };

    return ControllerView;

  })(Backbone.View);

  namespace('jmbo.ui.view', function(exports) {
    exports.Controller = Controller;
    exports.Controllers = Controllers;
    return exports.ControllerView = ControllerView;
  });

}).call(this);
