# Superleggera
Monitor your CSS in development to create a whitelist for PurgeCSS
in Rails with Webpacker.

This can be used to purge unused CSS classes from Bootstrap,
TailwindCSS, or any other CSS framework you include in Webpacker.

## Usage
How to use my plugin.

## Installation
Add this line to your application's Gemfile:

```ruby
gem 'superleggera'
```

And then execute:
```bash
$ bundle
```

Or install it yourself as:
```bash
$ gem install superleggera
```

Make sure your app has Bootstrap, TailwindCSS, or another CSS framework
loaded via Webpacker and not the asset pipeline.

Then update your `config/webpack/development.js` file:

```
process.env.NODE_ENV = process.env.NODE_ENV || 'development'

const environment = require('./environment')


// Configure PurgeCSS
const PurgecssPlugin = require('purgecss-webpack-plugin')
const fs = require("fs")
const glob = require('glob-all')
const path = require('path')

var whitelist_path = "config/whitelist.json"
var whitelist = []

if (fs.existsSync(whitelist_path)) {
  whitelist = JSON.parse(fs.readFileSync(whitelist_path))
}

environment.plugins.append('PurgecssPlugin', new PurgecssPlugin({
  paths: glob.sync([
    path.join(__dirname, '../../app/views/**/*.html.erb'),
  ]),
  whitelist: whitelist
}))




module.exports = environment.toWebpackConfig()
```

## TODO
* When a Rails view is updated, we should also trigger webpack to rebuild the
CSS and autoreload if the webpack-dev-server is running. This is ideally
done via Webpacker monitoring of app/views, but we could also triggers
this when a request comes through the middleware.
* Process Vue, React, and Stimulus files to find more classes to
  whitelist

## License
The gem is available as open source under the terms of the [MIT License](https://opensource.org/licenses/MIT).
