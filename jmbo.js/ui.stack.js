// Generated by CoffeeScript 1.3.1
(function() {
  var ControllerView,
    __bind = function(fn, me){ return function(){ return fn.apply(me, arguments); }; },
    __hasProp = {}.hasOwnProperty,
    __extends = function(child, parent) { for (var key in parent) { if (__hasProp.call(parent, key)) child[key] = parent[key]; } function ctor() { this.constructor = child; } ctor.prototype = parent.prototype; child.prototype = new ctor; child.__super__ = parent.prototype; return child; };

  ControllerView = (function(_super) {

    __extends(ControllerView, _super);

    ControllerView.name = 'ControllerView';

    function ControllerView() {
      this.pop = __bind(this.pop, this);

      this.push = __bind(this.push, this);

      this.render = __bind(this.render, this);
      return ControllerView.__super__.constructor.apply(this, arguments);
    }

    ControllerView.prototype.className = 'jmbo-ui-stack-controller-view';

    ControllerView.prototype.initialize = function() {
      ControllerView.__super__.initialize.apply(this, arguments);
      return this.collection = new jmbo.ui.view.Controllers;
    };

    ControllerView.prototype.render = function() {
      var controller, view;
      this.$el.html('');
      controller = this.collection.last();
      if (controller != null) {
        view = controller.get('view');
        this.$el.html(view.render());
      }
      return this.el;
    };

    ControllerView.prototype.push = function(newView, options) {
      var controller, oldView;
      if (options == null) {
        options = {
          animation: 'slide-right'
        };
      }
      controller = this.collection.last();
      if (controller != null) {
        oldView = controller.get('view');
        oldView.animate(options.animation, 'out', function() {
          return oldView.$el.html('').remove();
        });
      }
      this.collection.add({
        'view': newView
      });
      this.$el.append(newView.render());
      newView.animate(options.animation, 'in');
      return newView;
    };

    ControllerView.prototype.pop = function(options) {
      var newController, newView, oldController, oldView;
      if (options == null) {
        options = {
          animation: 'slide-left'
        };
      }
      oldController = this.collection.pop();
      if (oldController != null) {
        oldView = oldController.get('view');
        oldView.animate(options.animation, 'out', function() {
          return oldView.$el.html('').remove();
        });
      }
      newController = this.collection.last();
      if (newController != null) {
        newView = newController.get('view');
        this.$el.append(newView.render());
        newView.animate(options.animation, 'in');
      }
      return oldView;
    };

    return ControllerView;

  })(jmbo.ui.view.ControllerView);

  namespace('jmbo.ui.stack', function(exports) {
    return exports.ControllerView = ControllerView;
  });

}).call(this);
