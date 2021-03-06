// Generated by CoffeeScript 1.3.3
(function() {
  var TitleView, exports, _ref,
    __bind = function(fn, me){ return function(){ return fn.apply(me, arguments); }; },
    __hasProp = {}.hasOwnProperty,
    __extends = function(child, parent) { for (var key in parent) { if (__hasProp.call(parent, key)) child[key] = parent[key]; } function ctor() { this.constructor = child; } ctor.prototype = parent.prototype; child.prototype = new ctor(); child.__super__ = parent.prototype; return child; };

  TitleView = (function(_super) {

    __extends(TitleView, _super);

    function TitleView() {
      this.renderAction = __bind(this.renderAction, this);

      this.render = __bind(this.render, this);
      return TitleView.__super__.constructor.apply(this, arguments);
    }

    TitleView.prototype.className = 'jmbo-title-view';

    TitleView.prototype.initialize = function() {};

    TitleView.prototype.render = function() {
      var action, _i, _len, _ref;
      this.$el.html("<h1>" + this.options.name + "</h1>");
      if (this.options.actions != null) {
        _ref = this.options.actions;
        for (_i = 0, _len = _ref.length; _i < _len; _i++) {
          action = _ref[_i];
          this.renderAction(action);
        }
      }
      return this;
    };

    TitleView.prototype.renderAction = function(action) {
      var $action, tap;
      tap = 'click';
      if (typeof Touch === 'object') {
        tap = 'touchstart';
      }
      $action = $('<div/>').addClass(action.extraClasses).html(action.name).on(tap, action.callback);
      return this.$el.append($action);
    };

    return TitleView;

  })(Backbone.View);

  exports = this;

  exports.Jmbo = (_ref = exports.Jmbo) != null ? _ref : {};

  exports.Jmbo.TitleView = TitleView;

}).call(this);
