// Generated by CoffeeScript 1.3.3
(function() {
  var ListItemView, ListView, exports, _ref,
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

    ListView.prototype.tagName = 'ol';

    ListView.prototype.initialize = function() {
      return this.collection.on('reset', this.render);
    };

    ListView.prototype.render = function() {
      var _this = this;
      this.$el.html('');
      if (this.collection.length === 0) {
        this.$el.html('<li class="loading">Loading...</li>');
      } else {
        this.collection.each(function(item, index) {
          _this.$el.append(new ListItemView({
            model: item
          }).render().el);
          return console.log(item);
        });
      }
      return this;
    };

    return ListView;

  })(Backbone.View);

  ListItemView = (function(_super) {

    __extends(ListItemView, _super);

    function ListItemView() {
      this.render = __bind(this.render, this);
      return ListItemView.__super__.constructor.apply(this, arguments);
    }

    ListItemView.prototype.className = 'jmbo-list-item-view';

    ListItemView.prototype.tagName = 'li';

    ListItemView.prototype.initialize = function() {};

    ListItemView.prototype.render = function() {
      this.$el.html('dsadas');
      return this;
    };

    return ListItemView;

  })(Backbone.View);

  exports = this;

  exports.Jmbo = (_ref = exports.Jmbo) != null ? _ref : {};

  exports.Jmbo.ListView = ListView;

}).call(this);
