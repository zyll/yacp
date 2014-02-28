(function() {
  describe('ArrayColors', function() {
    beforeEach(function() {
      return this.colors = new Backbone.Yacp.ColorsArray;
    });
    afterEach(function() {
      return this.colors.remove();
    });
    it('has a default cols number to 10', function() {
      return expect(this.colors.cols).to.be.eql(10);
    });
    it('use default colors array', function() {
      return expect(this.colors.colors).to.equal(Backbone.Yacp.prototype.defaultColors);
    });
    it('render all colors', function() {
      return expect(this.colors.render().$('td')).to.have.length(this.colors.colors.length);
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
      return expect(this.yacp.$('table')).to.have.length(2);
    });
    it('first list is default palette', function() {
      this.yacp.render();
      return expect(this.yacp.$('table').first().find('a')).to.have.length(Backbone.Yacp.prototype.defaultColors.length);
    });
    it('last list is an empty palette', function() {
      this.yacp.render();
      return expect(this.yacp.$('table').last().find('a')).to.have.length(0);
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

}).call(this);
