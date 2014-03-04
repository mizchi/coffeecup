module.exports = (grunt) ->
  grunt.loadNpmTasks('grunt-contrib-coffee')
  grunt.initConfig
    coffee:
      options:
        bare: true
      files:
        'src/coffeekup.coffee': 'lib/coffeekup.coffee'
        'src/compiler.coffee' : 'lib/compiler.coffee'
        'src/cli.coffee'      : 'lib/cli.coffee'
