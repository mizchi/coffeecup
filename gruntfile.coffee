module.exports = (grunt) ->
  grunt.loadNpmTasks('grunt-contrib-coffee')
  grunt.initConfig
    coffee:
      options:
        bare: true
      files:
        'src/coffeekup.coffee': 'lib/coffeekup.js'
        'src/compiler.coffee' : 'lib/compiler.js'
        'src/cli.coffee'      : 'lib/cli.js'
