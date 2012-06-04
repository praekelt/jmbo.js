// Generated by CoffeeScript 1.3.1
(function() {
  var TitleView,
    __bind = function(fn, me){ return function(){ return fn.apply(me, arguments); }; },
    __hasProp = {}.hasOwnProperty,
    __extends = function(child, parent) { for (var key in parent) { if (__hasProp.call(parent, key)) child[key] = parent[key]; } function ctor() { this.constructor = child; } ctor.prototype = parent.prototype; child.prototype = new ctor; child.__super__ = parent.prototype; return child; };

  TitleView = (function(_super) {

    __extends(TitleView, _super);

    TitleView.name = 'TitleView';

    function TitleView() {
      this.setTitle = __bind(this.setTitle, this);

      this.render = __bind(this.render, this);
      return TitleView.__super__.constructor.apply(this, arguments);
    }

    TitleView.prototype.className = 'jmbo-ui-title-view';

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

  namespace('jmbo.ui', function(exports) {
    exports.TitleView = TitleView;
    return exports.animate = function($el, name, direction, callback) {
      /*
          This function had a race condition problem:
      
          If you added many views to a navigation controller it's possible to add two
          animations to an element at the same time.
      
          The `in` animation would complete and remove the `animationEnd` callback, 
          which would inturn remove the callback for the `out` animation.
      
          So the `out` animation's callback would never fire. I've implemented custom
          events specific to the type of animation. `animationEnd` always fires, and
          triggers a custom event. The custom event can be removed without fear of
          removing any other callbacks.
      */

      var className, customAnimationEvent;
      className = name + '-' + direction;
      customAnimationEvent = 'anim-event-' + className;
      $el.addClass(className);
      $el.on(customAnimationEvent, function() {
        $el.off(customAnimationEvent);
        $el.removeClass(className);
        if (callback) {
          return callback();
        }
      });
      $el.on('webkitAnimationEnd animationEnd', function(e) {
        return $el.trigger(customAnimationEvent);
      });
      if (name === false) {
        return $el.trigger(customAnimationEvent);
      }
    };
  });

}).call(this);
