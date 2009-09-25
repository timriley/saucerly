Saucerly
========

Saucerly provides PDF rendering for your Rails app using the Java-based [FlyingSaucer](https://xhtmlrenderer.dev.java.net/) library.

It is based on [Princely](http://github.com/mbleigh/princely/). The benefit of Saucerly is that it provides competent XHTML to PDF rendering without the $4k PrinceXML pricetag.

Example
-------

Rendering from a template:

    class ExamplesController < ApplicationController::Base
      def show
        @document = Document.find(params[:id])
      
        respond_to do |format|
          format.html
          format.pdf { render :pdf => 'file_name', :template => 'controller/action.pdf.haml', :layout => 'pdf' }
        end
      end
    end
          
Rendering from an inline string:

    render :pdf => 'file_name', :inline => 'XHTML goes here'

Installation
------------

First, set up the dependencies:

1. Install [JRuby](http://jruby.org/)
2. Register the flying_saucer gem dependency: add `config.gem 'flying_saucer'` to `config/environment.rb`
3. Install flying_saucer: `jruby -S rake gems:install`

Then, install Saucerly:

* As a gem, add `config.gem 'timriley-saucerly', :source => 'http://gems.github.com/', :lib => 'saucerly'` to `config/environment.rb` and run `jruby -S rake gems:install`
* As a plugin, run `jruby script/plugin install git://github.com/timriley/saucerly`

Now you're ready to go! Add some code to your controllers like the examples above.

If you're developing on OS X and you don't want a Java icon to appear in your dock, put `java.lang.System.set_property("java.awt.headless", "true")` in `environment.rb` or an initializer

Copyright (c) 2009 Tim Riley & RentMonkey Pty Ltd, released under the MIT license