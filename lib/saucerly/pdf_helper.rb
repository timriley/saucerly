module Saucerly
  module PdfHelper
    def self.included(base)
      base.class_eval do
        alias_method_chain :render, :saucerly
      end
    end
  
    def render_with_saucerly(options = nil, *args, &block)
      if options.is_a?(Hash) && options.has_key?(:pdf)
        options[:name] ||= options.delete(:pdf)
        make_and_send_pdf(options.delete(:name), options)
      else
        render_without_saucerly(options, *args, &block)
      end
    end
  
    private
    
    def pdf_from_string(str)
      # These lines are extracted from ITextRenderer's #setDocumentFromString, which doesn't
      # seem to exist in the flying_saucer gem
      is = org.xml.sax.InputSource.new(java.io.BufferedReader.new(java.io.StringReader.new(str)))
      dom = org.xhtmlrenderer.resource.XMLResource.load(is).getDocument()

      renderer = org.xhtmlrenderer.pdf.ITextRenderer.new
      renderer.setDocument(dom, nil)
      renderer.layout

      output = java.io.ByteArrayOutputStream.new
      renderer.createPDF(output, true)
      
      String.from_java_bytes(output.to_byte_array)
    end
  
    def make_pdf(options = {})
      html_string = if options[:inline]
        render_to_string(:inline => options[:inline])
      else
        render_to_string(:template => options[:template], :layout => options[:layout])
      end
    
      # Make all paths relative, on disk paths...
      html_string.gsub!(".com:/",".com/") # strip out bad attachment_fu URLs
      html_string.gsub!(/src=["']+([^:]+?)["']/i) { |m| "src=\"#{Rails.root}/public/" + $1 + '"' } # re-route absolute paths
    
      # Remove asset ids on images with a regex
      html_string.gsub!(/src=["'](\S+\?\d*)["']/i) { |m| 'src="' + $1.split('?').first + '"' }
      pdf_from_string(html_string)
    end
  
    def make_and_send_pdf(pdf_name, options = {})
      send_data_options = {:filename => pdf_name + ".pdf", :type => 'application/pdf'}
      disposition       = options.delete(:disposition)
      send_data_options[:disposition] = disposition if disposition
      
      send_data(make_pdf(options), send_data_options) 
    end
  end
end