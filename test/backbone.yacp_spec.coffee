describe 'ArrayColors', ->
  beforeEach ->
    @colors = new Backbone.Yacp.ColorsArray
  afterEach ->
    @colors.remove()

  it 'use default colors array', ->
    expect(@colors.colors).to.equal Backbone.Yacp::defaultColors

  it 'render all colors', ->
    expect(@colors.render().$('li')).to.have.length @colors.colors.length

  it 'notify on clicking a color', ->
    spy = sinon.spy()
    @colors.render().listenTo @colors, 'select', spy
    @colors.$('a').first().click()
    expect(spy).to.have.been.calledOnce
    expect(spy).to.have.been.calledWith '#722929'

describe 'Yacp', ->
  beforeEach ->
    @yacp = new Backbone.Yacp
  afterEach ->
    @yacp.remove()

  it 'display 2 colors list', ->
    @yacp.render()
    expect(@yacp.$ 'ul').to.have.length 2

  it 'first list is default palette', ->
    @yacp.render()
    expect(@yacp.$('ul').first().find('a')).to.have.length Backbone.Yacp::defaultColors.length

  it 'last list is an empty palette', ->
    @yacp.render()
    expect(@yacp.$('ul').last().find('a')).to.have.length 0

  it 'notify on selecting a color in palette', ->
    spy = sinon.spy()
    @yacp.listenTo @yacp, 'select', spy
    @yacp.render().$('a').first().click()
    expect(spy).to.have.been.calledOnce
    expect(spy).to.have.been.calledWith '#722929'
