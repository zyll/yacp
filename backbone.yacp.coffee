class Backbone.Yacp extends Backbone.View
  defaultColors: [
    "#722929", "#7f7f26", "#497e25", "#487d7c", "#16166d", "#701f7f", "#7a7a7a", "#898989",
    "#73481a", "#5c7e24", "#477c4a", "#2b477b", "#3e1b71", "#712b56", "#da3535", "#f4f43d",
    "#8af33c", "#86ecec", "#ce16eb", "#b4f441", "#3a3a3a", "#a4f2f2", "#e58ad5", "#d4ff74",
    "#9fd1fd", "#f2ce79", "#b1b1fd", "#f5f5b2", "#b1b1b1", "#f2f2f2", "#fff", "#1919d0"
  ]

  tagName: 'section'
  className: 'yacp-container'

  events:
    'click a.yacp-custom': 'onCustom'

  words:
    custom: 'custom...'

  initialize: (options={})->
    @userColors = options.users || []
    @viewPalette = new Backbone.Yacp.ColorsArray
    @userPalette = new Backbone.Yacp.ColorsArray colors: @userColors

  render: ->
    @$custom = $ """<a href="#" class="yacp-custom">#{@words.custom}</a>"""
    @$el.append @viewPalette.render().el, @$custom, @userPalette.render().el
    @listenTo @viewPalette, 'select', @select
    @listenTo @userPalette, 'select', @select
    @

  select: (color)=>
    @trigger 'select', color

  onCustom: (event)->
    event.preventDefault()
    @viewPalette.remove()
    @$custom.remove()
    @userPalette.remove()
    @minicolors = new Backbone.Yacp.Minicolors
    @$el.append @minicolors.render().el
    @listenTo @minicolors, 'select', (color)=>
      @userColors.push color
      @select color

  remove: ->
    @viewPalette?.remove()
    @$custom.remove()
    @$custom?.remove()
    @userPalette?.remove()
    @minicolors?.remove()
    super

# @params [options] {object}
# @params [options.colors] {array} colors arrays, default to libs one
# @params [options.minicolors] {object} see https://github.com/claviska/jquery-minicolors
class Backbone.Yacp.ColorsArray extends Backbone.View
  tagName: 'ul'

  events:
    'click a.yacp-color': 'onSelect'

  initialize: (options={})->
    @colors = options.colors || Backbone.Yacp::defaultColors
    @minicolors = options.minicolors || inline: on

  render: ->
    @$content = $ '<div/>'
    for color in @colors
      @$content.append $ """<li><a href="#" class="yacp-color" style="background-color: #{color};" data-color=#{color}></a></li>"""
    @$el.html @$content.contents()
    @

  onSelect: (event)->
    event.preventDefault()
    @trigger 'select', $(event.currentTarget).data 'color'

class Backbone.Yacp.Minicolors extends Backbone.View

  tagName: 'article'
  className: 'yacp-minicolors'

  events:
    'click a.yacp-confirm': 'onConfirm'

  words:
    confirm: 'Ok'

  render: ->
    @$confirm = $ """<a href="#" class="yacp-confirm">#{@words.confirm}</a>"""
    @$minicolors = $ """<input class="minicolors" type="hidden">"""
    @$el.append @$minicolors, @$confirm
    @$minicolors.minicolors('create', @minicolors).minicolors('show')
    @

  onConfirm: (event)->
    event.preventDefault()
    @trigger 'select', @$minicolors.val()


# @params [options] {object}
# @params [options.el] {domElement}
# @params [options.users] {array} customs colors arrays, default to empty
# @params [options.input] {DomElement} input form field witch handle the colors
# @params [options.color] {DomElement} feedback domelement with real color
# @params [options.minicolors] {object} see https://github.com/claviska/jquery-minicolors
class Backbone.Yacp.Input extends Backbone.View
  className: 'yacp-colorSelector'

  events:
    'click input': 'onClick'

  initialize: (options={})->
    @$el.toggleClass @className, on
    @users = options.users || []
    @$color = $ options.color
    @$input = $ options.input
    @background @$color, v unless _(v = @$input.val()).isEmpty()
    @minicolors = options.minicolors || online: on
    @yacp = null

  onClick: (event)->
    event.preventDefault()
    if @yacp? then @hide() else @show()

  show: ->
    @yacp = new Backbone.Yacp
      users: @users
      minicolors: @minicolors
    @$input.after @yacp.render().el
    @yacp.listenTo @yacp, 'select', (color)=>
      @$input.attr(value: color).change()
      @background @$color, color
      @yacp.remove()
      @yacp = null
      @trigger 'select', color

  hide: ->
    @yacp?.remove()
    @yacp = null

  background: ($el, color)->
    $el.css 'background-color', color

  remove: ->
    @$el.toggleClass @className, off
    @yacp?.remove()
    super
