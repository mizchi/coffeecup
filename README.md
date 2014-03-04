# CoffeeCup <☕/>
## Markup as CoffeeScript

This is a clone of @gradus [CoffeeCup](https://github.com/gradus/coffeekup).

To Build by grunt and apply bower.


## Install

node

```
    npm install coffeecup
```

bower

```
    bower install git@github.com:mizchi/coffeecup.git
```


## What's this?

CoffeeCup is a templating engine for [node.js](http://nodejs.org) and browsers that lets you to write your HTML templates in 100% pure [CoffeeScript](http://coffeescript.org).

Here's what a template written for CoffeeCup looks like:

    doctype 5
    html ->
      head ->
        meta charset: 'utf-8'
        title "#{@title or 'Untitled'} | A completely plausible website"
        meta(name: 'description', content: @description) if @description?

        link rel: 'stylesheet', href: '/css/app.css'

        style '''
          body {font-family: sans-serif}
          header, nav, section, footer {display: block}
        '''

        comment 'Stylus is supported as well'

        stylus '''
          body
            margin: 0
        '''

        script src: '/js/jquery.js'

        coffeescript ->
          $(document).ready ->
            alert 'Alerts suck!'
      body ->
        header ->
          h1 @title or 'Untitled'

          nav ->
            ul ->
              (li -> a href: '/', -> 'Home') unless @path is '/'
              li -> a href: '/chunky', -> 'Bacon!'
              switch @user.role
                when 'owner', 'admin'
                  li -> a href: '/admin', -> 'Secret Stuff'
                when 'vip'
                  li -> a href: '/vip', -> 'Exclusive Stuff'
                else
                  li -> a href: '/commoners', -> 'Just Stuff'

        div '#myid.myclass.anotherclass', style: 'position: fixed', ->
          p 'Divitis kills! Inline styling too.'

        section ->
          # A helper function you built and included.
          breadcrumb separator: '>', clickable: yes

          h2 "Let's count to 10:"
          p i for i in [1..10]

          # Another hypothetical helper.
          form_to @post, ->
            textbox '#title', label: 'Title:'
            textbox '#author', label: 'Author:'
            submit 'Save'

        footer ->
          # CoffeeScript comments. Not visible in the output document.
          comment 'HTML comments.'
          p 'Bye!'

Interactive demo at [coffeekup.org](http://coffeekup.org).

Use compiler directly in code.

    cc = require 'coffeecup'
    cc.render -> h1 "You can feed me templates as functions."
    cc.render "h1 'Or strings. I am not too picky.'"

Defining variables:

    template = ->
      h1 @title
      form method: 'post', action: 'login', ->
        textbox id: 'username'
        textbox id: 'password'
        button @title

    helpers =
      textbox: (attrs) ->
        attrs.type = 'text'
        attrs.name = attrs.id
        input attrs

    cc.render(template, title: 'Log In', hardcode: helpers)

Precompiling to functions:

    template = cc.compile(template, locals: yes, hardcode: {zig: 'zag'})
    template(foo: 'bar', locals: {ping: 'pong'})

With [express](http://expressjs.com):

    app.set('view engine', 'coffee')
    app.engine 'coffee', require('coffeecup').__express

    app.get '/', (req, res) ->
      # Will render views/index.coffee:
      res.render 'index', foo: 'bar'

Command-line:

    $ coffeecup -h

    Usage:
      coffeecup [options] path/to/template.coffee

          --js           compile template to js function
      -n, --namespace    global object holding the templates (default: "templates")
      -w, --watch        watch templates for changes, and recompile
      -o, --output       set the directory for compiled html
      -p, --print        print the compiled html to stdout
      -f, --format       apply line breaks and indentation to html output
      -u, --utils        add helper locals (currently only "render")
      -v, --version      display CoffeeCup version
      -h, --help         display this help message

See [/examples](http://github.com/gradus/coffeekup/tree/master/examples) for complete versions (you have to run `cake build` first).

Please note that even though all examples are given in CoffeeScript, you can also use their plain JavaScript counterparts just fine.
