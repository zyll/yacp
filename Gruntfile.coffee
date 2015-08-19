module.exports = (grunt)->

  grunt.loadNpmTasks 'grunt-contrib-watch'
  grunt.loadNpmTasks 'grunt-contrib-jshint'
  grunt.loadNpmTasks 'grunt-contrib-stylus'
  grunt.loadNpmTasks 'grunt-coffeelint'
  grunt.loadNpmTasks 'grunt-mocha'
  grunt.loadNpmTasks 'grunt-browserify'

  grunt.initConfig
    coffeelint:
      app:
        files:
          src: ['Gruntfile.coffee', 'backbone.yacp.coffee', 'test/**/*.coffee']
        options:
          max_line_length:
            level: 'warn'
          no_backticks:
            level: 'warn'
    jshint:
      manifest: ['*.json']
    browserify:
      assets:
        src: ['./backbone.yacp.coffee']
        dest: 'backbone.yacp.js'
        options:
          browserifyOptions:
            standalone: 'backbone.yacp'
          external: ['jquery', 'backbone', 'underscore']
          transform: ['coffeeify']
      test:
        src: ['test/backbone.yacp_spec.coffee']
        dest: 'test/backbone.yacp_spec.js'
        options:
          transform: ['coffeeify']
    stylus:
      assets:
        files:
          'backbone.yacp.css': ['backbone.yacp.styl']
        options:
          'include css': true
    mocha:
      options:
        run: true
        log: true
      test:
        src: ['test/test.html']
    watch:
      files: ['*.coffee', 'test/**/*.coffee', '*.styl']
      tasks: ['coffeelint', 'browserify', 'stylus', 'mocha']

  grunt.registerTask 'default', ['jshint', 'coffeelint', 'browserify', 'stylus', 'mocha']
