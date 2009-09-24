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

1. Install [JRuby](http://jruby.org/)
2. Register the flying_saucer gem dependency `config.gem 'flying_saucer'` to your `config/environment.rb`
3. Install flying_saucer: `jruby -S rake gems:install`
4. Install Saucerly: `jruby script/plugin install git://github.com/timriley/saucerly`
5. Go!

Copyright (c) 2009 Tim Riley & RentMonkey Pty Ltd, released under the MIT license
