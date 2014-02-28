class Backbone.Yacp extends Backbone.View
  defaultColors: [
    "#722929", "#7f7f26", "#497e25", "#487d7c", "#16166d", "#701f7f", "#7a7a7a", "#898989",
    "#73481a", "#5c7e24", "#477c4a", "#2b477b", "#3e1b71", "#712b56", "#da3535", "#f4f43d",
    "#8af33c", "#86ecec", "#ce16eb", "#b4f441", "#3a3a3a", "#a4f2f2", "#e58ad5", "#d4ff74",
    "#9fd1fd", "#f2ce79", "#b1b1fd", "#f5f5b2", "#b1b1b1", "#f2f2f2", "#fff", "#1919d0"
  ]

  events:
    'click a.custom': 'onCustom'

  words:
    custom: 'custom...'

  initialize: (options={})->
    @userColors = options.users || []
    @viewPalette = new Backbone.Yacp.ColorsArray
    @userPalette = new Backbone.Yacp.ColorsArray colors: @userColors

  render: ->
    @$custom = $ """<a href="#" class="custom">#{@words.custom}</a>"""
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
# @params [options.cols] {integer} how many cols, default to 10
# @params [options.colors] {array} colors arrays, default to libs one
class Backbone.Yacp.ColorsArray extends Backbone.View
  tagName: 'table'

  events:
    'click a.color': 'onSelect'

  initialize: (options={})->
    @cols = options.cols || 10
    @colors = options.colors || Backbone.Yacp::defaultColors

  render: ->
    @$body = $ '<tbody></tbody>'
    pos = 0
    while pos < @colors.length and @cols
      @$body.append $row = $ '<tr></tr>'
      for col in [1..@cols] when pos < @colors.length
        $row.append $cell = $ """<td><a href="#" class="color" style="background-color: #{@colors[pos]};" data-color=#{@colors[pos]}>#{@colors[pos]}</a></td>"""
        pos++
    @$el.html @$body
    @

  onSelect: (event)->
    event.preventDefault()
    @trigger 'select', $(event.currentTarget).data 'color'

class Backbone.Yacp.Minicolors extends Backbone.View
  events:
    'click a.confirm': 'onConfirm'

  words:
    confirm: 'Ok'

  render: ->
    @$confirm = $ """<a href="#" class="confirm">#{@words.confirm}</a>"""
    @$minicolors = $ """<input class="minicolors" type="hidden">"""
    @$el.append @$confirm, @$minicolors
    @$minicolors.minicolors('create', inline: on).minicolors('show')
    @

  onConfirm: (event)->
    event.preventDefault()
    @trigger 'select', @$minicolors.val()
