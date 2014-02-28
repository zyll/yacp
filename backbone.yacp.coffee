class Backbone.Yacp extends Backbone.View
  defaultColors: [
    "#011", "#025", "#033", "#044", "#055", "#066", "#077", "#090",
    "#012", "#023", "#034", "#045", "#056", "#067", "#078", "#091",
    "#013", "#024", "#035", "#046", "#057", "#070", "#079", "#092",
    "#014", "#025", "#036", "#047", "#060", "#071", "#080", "#093"
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
