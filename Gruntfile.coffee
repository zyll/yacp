module.exports = (grunt)->

  grunt.loadNpmTasks 'grunt-contrib-watch'
  grunt.loadNpmTasks 'grunt-contrib-coffee'
  grunt.loadNpmTasks 'grunt-contrib-jshint'
  grunt.loadNpmTasks 'grunt-coffeelint'
  grunt.loadNpmTasks 'grunt-mocha'
  grunt.loadNpmTasks 'grunt-bower-task'

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
    coffee:
      assets:
        files:
          'backbone.yacp.js': ['backbone.yacp.coffee']
      test:
        files:
          'test/backbone.yacp_spec.js': ['test/backbone.yacp_spec.coffee']
    mocha:
      options:
        run: true
        log: true
      test:
        src: ['test/test.html']
    watch:
      files: ['*.coffee', 'test/**/*.coffee']
      tasks: ['coffeelint', 'coffee', 'mocha']
    bower:
      install:
        targetDir: 'bower_components'
        copy: no

  grunt.registerTask 'default', ['bower', 'jshint', 'coffeelint', 'coffee', 'mocha']
