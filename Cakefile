fs = require 'fs'
log = console.log

{print} = require 'util'
{spawn, exec} = require 'child_process'

# ANSI Terminal Colors
bold = `'\033[0;1m'`
green = `'\033[0;32m'`
reset = `'\033[0m'`
red = `'\033[0;31m'`

# ## *log*
#
# **given** string as a message
# **and** string as a color
# **and** optional string as an explaination
# **then** builds a statement and logs to console.
log = (message, color, explanation) -> console.log color + message + reset + ' ' + (explanation or '')

# ## *launch*
#
# **given** string as a cmd
# **and** optional array and option flags
# **and** optional callback
# **then** spawn cmd with options
# **and** pipe to process stdout and stderr respectively
# **and** on child process exit emit callback if set and status is 0
launch = (cmd, options=[], callback) ->
  app = spawn cmd, options
  app.stdout.pipe(process.stdout)
  app.stderr.pipe(process.stderr)
  app.on 'exit', (status) -> callback?() if status is 0

# ## *build*
#
# **given** optional boolean as watch
# **and** optional function as callback
# **then** invoke launch passing coffee command
# **and** defaulted options to compile src to lib
build = (watch, callback) ->
  if typeof watch is 'function'
    callback = watch
    watch = false

  options = ['-c', '-b', '-o', 'lib', 'src']
  options.unshift '-w' if watch
  launch 'coffee', options, callback

test = (callback) ->
  exec './node_modules/mocha/bin/mocha --compilers coffee:coffee-script/register', (err, stdout, stderr) ->
    if stderr
      console.log stderr
      callback(true)
    console.log stdout
    callback(false)

run = (args...) ->
  for a in args
    switch typeof a
      when 'string' then command = a
      when 'object'
        if a instanceof Array then params = a
        else options = a
      when 'function' then callback = a

  command += ' ' + params.join ' ' if params?
  cmd = spawn '/bin/sh', ['-c', command], options
  cmd.stdout.on 'data', (data) -> process.stdout.write data
  cmd.stderr.on 'data', (data) -> process.stderr.write data
  process.on 'SIGHUP', -> cmd.kill()
  cmd.on 'exit', (code) -> callback() if callback? and code is 0

# Cakefile Tasks
#
# ## *docs*
#
# Generate Annotated Documentation
#
# <small>Usage</small>
#
# ```
# cake docs
# ```
task 'docs', 'generate documentation', -> docco()

# ## *build*
#
# Builds Source
#
# <small>Usage</small>
#
# ```
# cake build
# ```
task 'build', 'compile source', -> build -> log ":)", green

# ## *watch*
#
# Builds your source whenever it changes
#
# <small>Usage</small>
#
# ```
# cake watch
# ```
task 'watch', 'compile and watch', -> build true, -> log ":-)", green

task 'test', ->
  test -> console.log 'Done!'

task 'bench', -> require('./benchmark').run()

