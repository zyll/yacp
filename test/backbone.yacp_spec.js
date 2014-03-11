(function() {
  var tplInput;

  describe('ArrayColors', function() {
    beforeEach(function() {
      return this.colors = new Backbone.Yacp.ColorsArray;
    });
    afterEach(function() {
      return this.colors.remove();
    });
    it('use default colors array', function() {
      return expect(this.colors.colors).to.equal(Backbone.Yacp.prototype.defaultColors);
    });
    it('render all colors', function() {
      return expect(this.colors.render().$('li')).to.have.length(this.colors.colors.length);
    });
    return it('notify on clicking a color', function() {
      var spy;
      spy = sinon.spy();
      this.colors.render().listenTo(this.colors, 'select', spy);
      this.colors.$('a').first().click();
      expect(spy).to.have.been.calledOnce;
      return expect(spy).to.have.been.calledWith('#722929');
    });
  });

  describe('Yacp', function() {
    beforeEach(function() {
      return this.yacp = new Backbone.Yacp;
    });
    afterEach(function() {
      return this.yacp.remove();
    });
    it('display 2 colors list', function() {
      this.yacp.render();
      return expect(this.yacp.$('ul')).to.have.length(2);
    });
    it('first list is default palette', function() {
      this.yacp.render();
      return expect(this.yacp.$('ul').first().find('a')).to.have.length(Backbone.Yacp.prototype.defaultColors.length);
    });
    it('last list is an empty palette', function() {
      this.yacp.render();
      return expect(this.yacp.$('ul').last().find('a')).to.have.length(0);
    });
    return it('notify on selecting a color in palette', function() {
      var spy;
      spy = sinon.spy();
      this.yacp.listenTo(this.yacp, 'select', spy);
      this.yacp.render().$('a').first().click();
      expect(spy).to.have.been.calledOnce;
      return expect(spy).to.have.been.calledWith('#722929');
    });
  });

  tplInput = function() {
    return "<p id=\"color\">\n  <span class='color'></span>\n  <input placeholder='Color...'/>\n</p>";
  };

  describe('Yacp input', function() {
    beforeEach(function() {
      var $el;
      $el = $(tplInput());
      this.users = [];
      return this.yacp = new Backbone.Yacp.Input({
        el: $el,
        users: this.users,
        input: $el.find('input'),
        color: $el.find('i.color')
      });
    });
    afterEach(function() {
      return this.yacp.remove();
    });
    return describe('when clicking on input', function() {
      beforeEach(function() {
        return this.yacp.render().$('input').click();
      });
      it('display 2 colors list ', function() {
        return expect(this.yacp.$('ul')).to.have.length(2);
      });
      return describe('when clicking on first color ', function() {
        beforeEach(function() {
          this.spy = sinon.spy();
          this.yacp.listenTo(this.yacp, 'select', this.spy);
          return this.yacp.render().$('a').first().click();
        });
        return it('notify with first color', function() {
          expect(this.spy).to.have.been.calledOnce;
          return expect(this.spy).to.have.been.calledWith('#722929');
        });
      });
    });
  });

  describe('Yacp input with a default color', function() {
    beforeEach(function() {
      this.$el = $(tplInput());
      this.$el.find('input').val('#333333');
      this.users = [];
      return this.yacp = new Backbone.Yacp.Input({
        el: this.$el,
        users: this.users,
        input: this.$el.find('input'),
        color: this.$el.find('.color')
      });
    });
    afterEach(function() {
      return this.yacp.remove();
    });
    return it('sync color visual feedback', function() {
      return expect(this.$el.find('.color').css('background-color')).to.eql("rgb(51, 51, 51)");
    });
  });

}).call(this);
