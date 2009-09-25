require 'java'
require 'flying_saucer'

require 'saucerly/pdf_helper'

Mime::Type.register 'application/pdf', :pdf
ActionController::Base.send(:include, Saucerly::PdfHelper)