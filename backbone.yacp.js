(function() {
  var _ref, _ref1, _ref2,
    __bind = function(fn, me){ return function(){ return fn.apply(me, arguments); }; },
    __hasProp = {}.hasOwnProperty,
    __extends = function(child, parent) { for (var key in parent) { if (__hasProp.call(parent, key)) child[key] = parent[key]; } function ctor() { this.constructor = child; } ctor.prototype = parent.prototype; child.prototype = new ctor(); child.__super__ = parent.prototype; return child; };

  Backbone.Yacp = (function(_super) {
    __extends(Yacp, _super);

    function Yacp() {
      this.select = __bind(this.select, this);
      _ref = Yacp.__super__.constructor.apply(this, arguments);
      return _ref;
    }

    Yacp.prototype.defaultColors = ["#011", "#025", "#033", "#044", "#055", "#066", "#077", "#090", "#012", "#023", "#034", "#045", "#056", "#067", "#078", "#091", "#013", "#024", "#035", "#046", "#057", "#070", "#079", "#092", "#014", "#025", "#036", "#047", "#060", "#071", "#080", "#093"];

    Yacp.prototype.events = {
      'click a.custom': 'onCustom'
    };

    Yacp.prototype.words = {
      custom: 'custom...'
    };

    Yacp.prototype.initialize = function(options) {
      if (options == null) {
        options = {};
      }
      this.userColors = options.users || [];
      this.viewPalette = new Backbone.Yacp.ColorsArray;
      return this.userPalette = new Backbone.Yacp.ColorsArray({
        colors: this.userColors
      });
    };

    Yacp.prototype.render = function() {
      this.$custom = $("<a href=\"#\" class=\"custom\">" + this.words.custom + "</a>");
      this.$el.append(this.viewPalette.render().el, this.$custom, this.userPalette.render().el);
      this.listenTo(this.viewPalette, 'select', this.select);
      this.listenTo(this.userPalette, 'select', this.select);
      return this;
    };

    Yacp.prototype.select = function(color) {
      return this.trigger('select', color);
    };

    Yacp.prototype.onCustom = function(event) {
      var _this = this;
      event.preventDefault();
      this.viewPalette.remove();
      this.$custom.remove();
      this.userPalette.remove();
      this.minicolors = new Backbone.Yacp.Minicolors;
      this.$el.append(this.minicolors.render().el);
      return this.listenTo(this.minicolors, 'select', function(color) {
        _this.userColors.push(color);
        return _this.select(color);
      });
    };

    Yacp.prototype.remove = function() {
      var _ref1, _ref2, _ref3, _ref4;
      if ((_ref1 = this.viewPalette) != null) {
        _ref1.remove();
      }
      this.$custom.remove();
      if ((_ref2 = this.$custom) != null) {
        _ref2.remove();
      }
      if ((_ref3 = this.userPalette) != null) {
        _ref3.remove();
      }
      if ((_ref4 = this.minicolors) != null) {
        _ref4.remove();
      }
      return Yacp.__super__.remove.apply(this, arguments);
    };

    return Yacp;

  })(Backbone.View);

  Backbone.Yacp.ColorsArray = (function(_super) {
    __extends(ColorsArray, _super);

    function ColorsArray() {
      _ref1 = ColorsArray.__super__.constructor.apply(this, arguments);
      return _ref1;
    }

    ColorsArray.prototype.tagName = 'table';

    ColorsArray.prototype.events = {
      'click a.color': 'onSelect'
    };

    ColorsArray.prototype.initialize = function(options) {
      if (options == null) {
        options = {};
      }
      this.cols = options.cols || 10;
      return this.colors = options.colors || Backbone.Yacp.prototype.defaultColors;
    };

    ColorsArray.prototype.render = function() {
      var $cell, $row, col, pos, _i, _ref2;
      this.$body = $('<tbody></tbody>');
      pos = 0;
      while (pos < this.colors.length && this.cols) {
        this.$body.append($row = $('<tr></tr>'));
        for (col = _i = 1, _ref2 = this.cols; 1 <= _ref2 ? _i <= _ref2 : _i >= _ref2; col = 1 <= _ref2 ? ++_i : --_i) {
          if (!(pos < this.colors.length)) {
            continue;
          }
          $row.append($cell = $("<td><a href=\"#\" class=\"color\" style=\"background-color: " + this.colors[pos] + ";\" data-color=" + this.colors[pos] + ">" + this.colors[pos] + "</a></td>"));
          pos++;
        }
      }
      this.$el.html(this.$body);
      return this;
    };

    ColorsArray.prototype.onSelect = function(event) {
      event.preventDefault();
      return this.trigger('select', $(event.currentTarget).data('color'));
    };

    return ColorsArray;

  })(Backbone.View);

  Backbone.Yacp.Minicolors = (function(_super) {
    __extends(Minicolors, _super);

    function Minicolors() {
      _ref2 = Minicolors.__super__.constructor.apply(this, arguments);
      return _ref2;
    }

    Minicolors.prototype.events = {
      'click a.confirm': 'onConfirm'
    };

    Minicolors.prototype.words = {
      confirm: 'Ok'
    };

    Minicolors.prototype.render = function() {
      this.$confirm = $("<a href=\"#\" class=\"confirm\">" + this.words.confirm + "</a>");
      this.$minicolors = $("<input class=\"minicolors\" type=\"hidden\">");
      this.$el.append(this.$confirm, this.$minicolors);
      this.$minicolors.minicolors('create', {
        inline: true
      }).minicolors('show');
      return this;
    };

    Minicolors.prototype.onConfirm = function(event) {
      event.preventDefault();
      return this.trigger('select', this.$minicolors.val());
    };

    return Minicolors;

  })(Backbone.View);

}).call(this);
