# frozen_string_literal: true

require_relative 'write_invoice/version'

require_relative './write_invoice/example/index'

require_relative './write_invoice/document/index'
require_relative './write_invoice/document/options'
require_relative './write_invoice/document/sections'

require 'json'
require 'prawn/table'
require 'prawn'
require 'prawn/measurement_extensions'

require 'active_support'
require 'active_support/core_ext'

require 'prawn/qrcode'
require 'date'
require 'faker'


module WriteInvoice
  class Error < StandardError; end

  
  class Example
    extend Exmple

    def self.generate( invoices_total: 3..6, articles_total: 2..6, debug: true ) 
      payload = examples_generate( invoices_total: invoices_total, articles_total: articles_total )
      debug ? puts( "Example       #{payload[:document][:encrypt][:user_password]}" ) : ''
      return payload
    end
  end


  class Document
    extend Dcmnt
    extend Options
    extend Sections

    def self.generate( output: nil, payload: nil, options: {}, debug: true )

      template = Marshal.load( Marshal.dump( get_options ) )
      valid, messages = options_update( options, template, true )

      if valid
        debug ? print( 'Document      ' ) : ''
        pdf = self.document( template, options, payload, output, debug )
        debug ? puts : ''
        debug ? puts( "Pages Total   #{pdf.page_count}" ) : ''

        if output.nil?
          doc = pdf.render
          return doc
        else
          pdf.render_file( output )
          return true
        end

      else
        return messages
      end
    end

  end
end
