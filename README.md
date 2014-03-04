# CoffeeCup <☕/>
## Markup as CoffeeScript

This is a fork of @gradus [CoffeeCup](https://github.com/gradus/coffeekup).

To Build by grunt and apply bower. I love this project but original coffeecup is not maintained.

## Install and Use

### npm

```
$ npm install git@github.com:mizchi/coffeecup.git
```

```coffeescript
cc = require 'coffeecup'
cc.render -> h1 "You can feed me templates as functions."
```

### bower

```
$ bower install coffeekup #=> mizchi/coffeekup
```

Unfortunately, original coffeekup project is not active now so I(mizchi) added.

```coffeescript
coffeecup.render -> h1 "You can feed me templates as functions."
```

## What's this?

CoffeeCup is a templating engine for [node.js](http://nodejs.org) and browsers that lets you to write your HTML templates in 100% pure [CoffeeScript](http://coffeescript.org).

Here's what a template written for CoffeeCup looks like:

```coffeescript
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
```

See command line help by `npm install -g git@github.com:mizchi/coffeecup.git` and exec `coffeecup -h`

## Precompiling

```
template = cc.compile(template, locals: yes, hardcode: {zig: 'zag'})
template(foo: 'bar', locals: {ping: 'pong'})
```

Exec bench by `./bench/benchmark` if you want to know more.

## for Express

[express](http://expressjs.com):

```
app.set('view engine', 'coffee')
app.engine 'coffee', require('coffeecup').__express

app.get '/', (req, res) ->
  # Will render views/index.coffee:
  res.render 'index', foo: 'bar'
```
