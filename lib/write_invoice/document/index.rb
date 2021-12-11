module Dcmnt
  private


  def document( template, options, payloads, output, debug ) 
    payloads = payloads.with_indifferent_access
    opts = options_update( Marshal.load( Marshal.dump( options ) ), template, false )
    obj = document_invoice_prepare( payloads[:invoices][ 0 ], opts )
    
    Prawn::Font::AFM.hide_m17n_warning = true
    pdf = Prawn::Document.new( 
      page_size: obj[:style][:document][:format],
      info: { 
        Title: payloads[:document][:metadata][:title],
        Author: payloads[:document][:metadata][:author],
        Subject: payloads[:document][:metadata][:subject],
      }
    )

    if !obj[:style][:font][:family].empty? 
      pdf.font_families.update( obj[:style][:font][:family] )
    end

    pdf.repeat :all do
      pdf.bounding_box [ pdf.bounds.left, obj[:style][:footer][:height] ], width: pdf.bounds.width do  
        pdf = pdf_generate_footer( obj, pdf )      
      end
    end

    a = [ 0, pdf.bounds.height ]
    b = pdf.bounds.width
    c = pdf.bounds.height - obj[:style][:footer][:height] - 10 

    states = []
    pdf.bounding_box( a, width: b, height: c ) do
      payloads[:invoices].each.with_index do | payload, index |
        debug ? print( "#{index} " ) : ''

        states.push( {
          id: payload[:meta][:id],
          page: pdf.page_number,
          headline: payload[:meta][:headline].to_s,
          group: payload[:meta][:group].to_s
        } )

        opts = options_update( Marshal.load( Marshal.dump( options ) ), template, false )
        obj = document_invoice_prepare( payload, opts )
        pdf = document_invoice( obj, output, pdf )

        if payloads[:invoices].length - 1 != index
          pdf.start_new_page
        end
      end
    end

    pdf = watermark_pages_number( pdf, states, obj )
    pdf = table_of_contents( states, pdf )
    obj[:show][:watermark] ? pdf = watermark( pdf, obj ) : ''

    if !obj[:show][:unencrypted]
      if !payloads[:document][:encrypt].nil?
        pdf.encrypt_document(
          user_password: payloads[:document][:encrypt][:user_password],
          owner_password: payloads[:document][:encrypt][:owner_password],
          permissions: {
            print_document: payloads[:document][:encrypt][:permissions][:print_document],
            modify_contents: payloads[:document][:encrypt][:permissions][:modify_contents],
            copy_contents: payloads[:document][:encrypt][:permissions][:copy_contents],
            modify_annotations: payloads[:document][:encrypt][:permissions][:modify_annotations] 
          }
        )
      else
        puts 'Payload: Error! Encrypt - Hash Block is missing. '
      end
    end

    return pdf
  end
    
    
  def document_invoice( obj, output, pdf )
    start = pdf.cursor
    obj[:order].each do | order |
      move = 0
      order[:move_down].each do | a |
        if a.class.to_s.eql?( 'Integer' )
          move += a
        else
          keys = a.to_s.split( '__' ).map { | a | a.to_sym }
          move += obj[ keys[ 0 ] ][ keys[ 1 ] ][ keys[ 2 ] ] 
        end
      end

      pdf.move_down( move )

      case order[:name]
        when :header
          pdf = pdf_generate_header( obj, pdf )
        when :two
          pdf = pdf_generate_two( obj, pdf )
        when :three
          pdf = pdf_generate_three( obj, pdf )
        when :four
          pdf = pdf_generate_four( obj, pdf )
        when :five
          pdf = pdf_generate_five( obj, pdf )
        when :six
          pdf = pdf_generate_six( obj, pdf )
        when :seven
          pdf = pdf_generate_seven( obj, pdf )
        when :eight
          pdf = pdf_generate_eight( obj, pdf )
        # when :nine
          # pdf = pdf_generate_nine( obj, pdf )
      end
    end

    return pdf
  end


  def document_invoice_prepare( payload, options )    
    alpha = 'a'.upto( 'z' ).to_a
    payload = Marshal.load( Marshal.dump( payload ) )
    options = Marshal.load( Marshal.dump( options ) )

    messages = { footer: [] }
  
    options[:sections].keys.each do | section |
      options[:sections][ section ].keys.each do | key |
        options[:sections][ section ][ key ][:content] = options[:sections][ section ][ key ][:struct].dup
        options[:sections][ section ][ key ][:assigns].each.with_index do | assign, i |
          prepare = {}
          [ :value, :format ].each do | sym |
            keys = assign[ sym ].to_s.split( '__' ).map { | a | a.to_sym }
            keys[ 0 ].eql?( :payload ) ? data = payload : data = options
            prepare[ sym ] = get_value( keys, data, true )
            if sym.eql?( :format )
              if keys.length != 0
                prepare[ :type ] = keys[ 2 ]
              else
                prepare[ :type ] = nil
              end
            end
          end

          insert = get_format( 
            prepare[:type], 
            prepare[:value], 
            prepare[:format]
          )

          options[:sections][ section ][ key ][:content] = 
            options[:sections][ section ][ key ][:content]
              .gsub!( "<<--#{alpha[ i ]}-->>", insert.to_s )
        end
      end
    end
  
    payload[:items].keys.each do | key |
      if payload[:items][ key ].class.to_s.eql?( 'Array' )
        payload[:items][ key ].each.with_index do | article, index |
          [ :single, :total ].each do | k |
            keys = options[:style][:articles][ k ][:format]
              .to_s.split( '__' ).map { | a | a.to_sym }

            params = get_value( keys, options, false )
            str = get_format( keys[ 1 ], article[ k ], params )
            payload[:items][ key ][ index ][ k ] = str
          end     
        end
      else
        keys = options[:style][:articles][:total][:format]
          .to_s.split( '__' )
          .map { | a | a.to_sym }

        params = get_value( keys, options, false )
        str = get_format( keys[ 1 ], payload[:items][ key ], params )
        payload[:items][ key ] = str
      end
    end

    options[:items] = payload[:items]
    options[:style][:document][:width] = options[:style][:articles]
      .keys
      .map { | key | options[:style][:articles][ key ][:width] }
      .sum

    return options
  end


  def watermark( pdf, obj )
    pdf.create_stamp( 'watermark' ) do
      struct = {
        font_size: obj[:style][:watermark][:font_size],
        text: {
          str: obj[:text][:watermark],
          width: nil
        },
        midpoint: {
          x: pdf.bounds.width / 2,
          y: pdf.bounds.height / 2
        },
        at: {
          x: nil,
          y: nil
        }
      }

      pdf.font obj[:style][:watermark][:font_family]
      struct[:text][:width] = pdf.font.compute_width_of( struct[:text][:str], size: struct[:font_size] )
      struct[:at][:x] = struct[:midpoint][:x] - ( struct[:text][:width] / 2 )
      struct[:at][:y] = struct[:midpoint][:y] + ( struct[:font_size] / 2 )

      pdf.fill_color obj[:style][:watermark][:fill_color]
      pdf.font_size( struct[:font_size] ) do
        pdf.transparent( obj[:style][:watermark][:transparency] ) do
          pdf.text_box(
            struct[:text][:str],
            at: [ struct[:at][:x], struct[:at][:y] ],
            width: struct[:text][:width],
            height: struct[:font_size],
            rotate: obj[:style][:watermark][:rotate],
            valign: :center,
            halign: :center,
            rotate_around: :center
          )
        end
      end
    end

    pdf.repeat :all do
      pdf.stamp_at 'watermark', [ 0, 0 ]
    end

    return pdf
  end


  def watermark_pages_number( pdf, states, obj )
    tmp = states
      .map.with_index { | state, index | 
        if !( index == states.length - 1 )
          state[:page_count] = states[ index + 1 ][:page] - 1
        else
          state[:page_count] = pdf.page_count
        end
        state[:pages] = ( state[:page_count] - state[:page] ) + 1
        state
      }

    b = tmp
      .map { | aa | aa[:pages].times.map { | index | { id: aa[:id], page: index + 1, total: aa[:pages] } } }
      .flatten
      .map.with_index { | a, index | a[:index] = index; a }

    b.each { | p | pdf_generate_nine( obj, pdf, p ) }

    return pdf
  end


  def table_of_contents( states, pdf )
    groups = states
      .map { | a | a[:group] }
      .to_set.to_a.sort
      .inject( {} ) { | item, key |
        item[ key ] = states
          .select { | a | a[:group].eql?( key ) }
          .sort_by { | a | a[:headline] }
        item
      }

    pdf.outline.define do
      groups.keys.each do | key |
        group = groups[ key ]
        section( key.to_s, destination: groups[ key ][ 0 ][:page]) do
          group.each do | invoice |
            pdf.outline.page( title: invoice[:headline], destination: invoice[:page])
          end
        end
      end
    end

    return pdf
  end

end