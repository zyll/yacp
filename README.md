Backbone Yacp [![Build Status](https://travis-ci.org/zyll/yacp.png)](https://travis-ci.org/zyll/yacp) [![Dependency Status](https://david-dm.org/zyll/yacp.png)](https://david-dm.org/zyll/yacp)
==============

## Usage

Your not from the past :

  bower install zyll/yacp

yacp deps :

  jquery, backbone and colorpicker (yep we use one, yacp purpose isnt to
  invent the wheel)

### Exemple

``` html
  <p id="color">
    <span class='color'></span>
    <input placeholder='Color...'/>
  </p>
```
```javascript
  var users = [];
  var $el = $('#color');
  var color = new Backbone.Yacp.Input({
    el: $el,
    users: users,
    input: $el.find('input'),
    color: $el.find('.color'),
    minicolors: {
      opacity: true
    }
  });
  color.render();
  color.on('select', function(color) {
    $('#myColor').css('background-color', color).text(color);
  });
```

## Developers

### Dependencies

* node
* grunt

custom ui color picker fallback on [jquery minicolors](https://github.com/claviska/jquery-minicolors).

## Install

Run `npm install && npm test`

### Testing

Run `grunt` to transpile and execute the specs.

You can watch for file modfication with `grunt watch`.


## Credits

Copyright (c) 2013 af83

Released under the MIT license
