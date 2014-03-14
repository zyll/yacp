(function() {
  var _ref, _ref1, _ref2, _ref3,
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

    Yacp.prototype.defaultColors = ["#722929", "#7f7f26", "#497e25", "#487d7c", "#16166d", "#701f7f", "#7a7a7a", "#898989", "#73481a", "#5c7e24", "#477c4a", "#2b477b", "#3e1b71", "#712b56", "#da3535", "#f4f43d", "#8af33c", "#86ecec", "#ce16eb", "#b4f441", "#3a3a3a", "#a4f2f2", "#e58ad5", "#d4ff74", "#9fd1fd", "#f2ce79", "#b1b1fd", "#f5f5b2", "#b1b1b1", "#f2f2f2", "#fff", "#1919d0"];

    Yacp.prototype.tagName = 'section';

    Yacp.prototype.className = 'yacp-container';

    Yacp.prototype.events = {
      'click a.yacp-custom': 'onCustom'
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
      this.$custom = $("<a href=\"#\" class=\"yacp-custom\">" + this.words.custom + "</a>");
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
      this.$custom.hide();
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

    ColorsArray.prototype.tagName = 'ul';

    ColorsArray.prototype.events = {
      'click a.yacp-color': 'onSelect'
    };

    ColorsArray.prototype.initialize = function(options) {
      if (options == null) {
        options = {};
      }
      this.colors = options.colors || Backbone.Yacp.prototype.defaultColors;
      return this.minicolors = options.minicolors || {
        inline: true
      };
    };

    ColorsArray.prototype.render = function() {
      var color, _i, _len, _ref2;
      this.$content = $('<div/>');
      _ref2 = this.colors;
      for (_i = 0, _len = _ref2.length; _i < _len; _i++) {
        color = _ref2[_i];
        this.$content.append($("<li><a href=\"#\" class=\"yacp-color\" style=\"background-color: " + color + ";\" data-color=" + color + "></a></li>"));
      }
      this.$el.html(this.$content.contents());
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

    Minicolors.prototype.tagName = 'article';

    Minicolors.prototype.className = 'yacp-minicolors';

    Minicolors.prototype.events = {
      'click a.yacp-confirm': 'onConfirm'
    };

    Minicolors.prototype.words = {
      confirm: 'Ok'
    };

    Minicolors.prototype.render = function() {
      this.$confirm = $("<a href=\"#\" class=\"yacp-confirm\">" + this.words.confirm + "</a>");
      this.$minicolors = $("<input class=\"minicolors\" type=\"hidden\">");
      this.$el.append(this.$minicolors, this.$confirm);
      this.$minicolors.minicolors('create', this.minicolors).minicolors('show');
      return this;
    };

    Minicolors.prototype.onConfirm = function(event) {
      event.preventDefault();
      return this.trigger('select', this.$minicolors.val());
    };

    return Minicolors;

  })(Backbone.View);

  Backbone.Yacp.Input = (function(_super) {
    __extends(Input, _super);

    function Input() {
      _ref3 = Input.__super__.constructor.apply(this, arguments);
      return _ref3;
    }

    Input.prototype.className = 'yacp-colorSelector';

    Input.prototype.events = {
      'click input': 'onClick'
    };

    Input.prototype.initialize = function(options) {
      var v;
      if (options == null) {
        options = {};
      }
      this.$el.toggleClass(this.className, true);
      this.users = options.users || [];
      this.$color = $(options.color);
      this.$input = $(options.input);
      if (!_(v = this.$input.val()).isEmpty()) {
        this.background(this.$color, v);
      }
      this.minicolors = options.minicolors || {
        online: true
      };
      return this.yacp = null;
    };

    Input.prototype.onClick = function(event) {
      event.preventDefault();
      if (this.yacp != null) {
        return this.hide();
      } else {
        return this.show();
      }
    };

    Input.prototype.show = function() {
      var _this = this;
      this.yacp = new Backbone.Yacp({
        users: this.users,
        minicolors: this.minicolors
      });
      this.$input.after(this.yacp.render().el);
      return this.yacp.listenTo(this.yacp, 'select', function(color) {
        _this.$input.attr({
          value: color
        }).change();
        _this.background(_this.$color, color);
        _this.yacp.remove();
        _this.yacp = null;
        return _this.trigger('select', color);
      });
    };

    Input.prototype.hide = function() {
      var _ref4;
      if ((_ref4 = this.yacp) != null) {
        _ref4.remove();
      }
      return this.yacp = null;
    };

    Input.prototype.background = function($el, color) {
      return $el.css('background-color', color);
    };

    Input.prototype.remove = function() {
      var _ref4;
      this.$el.toggleClass(this.className, false);
      if ((_ref4 = this.yacp) != null) {
        _ref4.remove();
      }
      return Input.__super__.remove.apply(this, arguments);
    };

    return Input;

  })(Backbone.View);

}).call(this);
