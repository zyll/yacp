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

tplInput = ->
  """
  <p id="color">
    <span class='color'></span>
    <input placeholder='Color...'/>
  </p>
  """

describe 'Yacp input', ->
  beforeEach ->
    @$el = $ tplInput()
    @users = []
    @yacp = new Backbone.Yacp.Input
      el: @$el
      users: @users
      input: @$el.find 'input'
      color: @$el.find '.color'
  afterEach ->
    @yacp.remove()

  describe 'when clicking on input', ->
    beforeEach ->
      @yacp.render().$('input').click()

    it 'display 2 colors list', ->
      expect(@yacp.$ 'ul').to.have.length 2

    it 'can be hidden', ->
      @yacp.hide()
      expect(@yacp.$ 'ul').not.to.have.length 2

    describe 'when clicking on first color ', ->
      beforeEach ->
        @spy = sinon.spy()
        @spyInput = sinon.spy()
        @$el.find('input').on 'change', @spyInput
        @yacp.listenTo @yacp, 'select', @spy
        @yacp.render().$('a').first().click()

      it 'notify with first color', ->
        expect(@spy).to.have.been.calledOnce
        expect(@spy).to.have.been.calledWith '#722929'

      it 'input element emit a change event', ->
        expect(@spyInput).to.have.been.calledOnce

  describe 'when clicking on color', ->
    beforeEach ->
      @yacp.render().$('.color').click()

    it 'display 2 colors list', ->
      expect(@yacp.$ 'ul').to.have.length 2

describe 'Yacp input with a default color', ->
  beforeEach ->
    @$el = $ tplInput()
    @$el.find('input').val '#333333'
    @users = []
    @yacp = new Backbone.Yacp.Input
      el: @$el
      users: @users
      input: @$el.find 'input'
      color: @$el.find '.color'
    @yacp.render()
  afterEach ->
    @yacp.remove()

  it 'sync color visual feedback', ->
    console.log @$el.find('.color')
    expect(@$el.find('.color').css 'background-color').to.eql "rgb(51, 51, 51)"
