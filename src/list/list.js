// Generated by CoffeeScript 1.3.3
(function() {
  var ListItemView, ListView,
    __bind = function(fn, me){ return function(){ return fn.apply(me, arguments); }; },
    __hasProp = {}.hasOwnProperty,
    __extends = function(child, parent) { for (var key in parent) { if (__hasProp.call(parent, key)) child[key] = parent[key]; } function ctor() { this.constructor = child; } ctor.prototype = parent.prototype; child.prototype = new ctor(); child.__super__ = parent.prototype; return child; };

  ListView = (function(_super) {

    __extends(ListView, _super);

    function ListView() {
      this.render = __bind(this.render, this);
      return ListView.__super__.constructor.apply(this, arguments);
    }

    ListView.prototype.className = 'jmbo-list-view';

    ListView.prototype.tagName = 'li';

    ListView.prototype.initialize = function() {};

    ListView.prototype.render = function() {};

    return ListView;

  })(Backbone.View);

  ListItemView = (function(_super) {

    __extends(ListItemView, _super);

    function ListItemView() {
      return ListItemView.__super__.constructor.apply(this, arguments);
    }

    return ListItemView;

  })(Backbone.View);

}).call(this);