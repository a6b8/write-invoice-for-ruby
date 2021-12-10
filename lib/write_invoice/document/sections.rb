module Sections
  private


  def pdf_generate_header( obj, pdf )
      
    pdf.font( obj[:style][:font][:name] ) 

    h = {
      grid: {
        length: {
          x: 5,
          y: 5
        },
        height: {
          total: nil,
          cell: nil,
          image: nil
        },
        width: {
          total: nil,
          cell: nil,
          image: nil
        }
      },
      box: {
        padding: 5,
        position: {
          x: nil,
          y: nil,
        },
        size: {
          width: nil,
          height: nil
        },
        range: {
          x: {
            min: nil,
            max: nil
          },
          y: {
            min: nil,
            max: nil
          }
        }
      },
      image: {
        image: nil, 
        fit: nil, 
        colspan: nil,
        rowspan: nil,
        borders: nil,
        border_width: nil
      }
    }

    h[:grid][:length][:x] = obj[:headline][:grid][:x]
    h[:grid][:length][:y] = obj[:headline][:grid][:y]

    h[:grid][:height][:total] = obj[:style][:header][:height]

    h[:box][:position][:x] = obj[:headline][:image][:grid][ 0 ]
    h[:box][:position][:y] = obj[:headline][:image][:grid][ 1 ]

    h[:box][:size][:width] = obj[:headline][:image][:colspan]
    h[:box][:size][:height] = obj[:headline][:image][:rowspan]

    h[:grid][:width][:total] = obj[:style][:document][:width]
      
    h[:grid][:width][:cell] = h[:grid][:width][:total] / h[:grid][:length][:x]
    h[:grid][:height][:cell] = h[:grid][:height][:total] / h[:grid][:length][:y]
    
    h[:grid][:width][:image] = ( h[:grid][:width][:cell] * h[:box][:size][:width] ) - h[:box][:padding] * 2
    h[:grid][:height][:image] = ( h[:grid][:height][:cell] * h[:box][:size][:height] ) - h[:box][:padding] * 2
    
    fit = [ h[:grid][:width][:image], h[:grid][:height][:image] ]
    obj[:headline][:image].key?( :fit ) ? fit = obj[:headline][:image][:fit] : ''

    if obj[:show][:logo]
      if !obj[:headline][:image][:src].to_s.split( '.' ).last.eql?( 'png' )
        h[:image][:image] = StringIO.new( Base64.decode64( obj[:headline][:image][:src] ) )
      else
        h[:image][:image] = obj[:headline][:image][:src]
      end

      h[:image][:fit] = fit
      h[:image][:colspan] = h[:box][:size][:width]
      h[:image][:rowspan] = h[:box][:size][:height]
      h[:image][:borders] = obj[:headline][:image][:borders]
      h[:image][:border_width] = obj[:headline][:image][:border_width]
    end

    [ { pos: :x, size: :width }, { pos: :y, size: :height } ].each do | axis |
      h[:box][:range][ axis[:pos ] ][:min] = h[:box][:position][ axis[:pos ] ]
      h[:box][:range][ axis[:pos ] ][:max] = h[:box][:range][ axis[:pos ] ][:min] + h[:box][:size][ axis[:size ] ] -1 
    end
    
    data = []
    h[:grid][:length][:y].times.each do | y |
      row = []
      h[:grid][:length][:x].times.each do | x |
        if( y == h[:box][:position][:y] and x == h[:box][:position][:x] )
          obj[:show][:logo] ? row.push( h[:image] ) : ''
        end 

        a = y.between?( h[:box][:range][:y][:min], h[:box][:range][:y][:max] )
        b = x.between?( h[:box][:range][:x][:min], h[:box][:range][:x][:max] )
        
        if( a and b )
        else
          r = obj[:headline][:texts].find { | item | item[:grid].eql?( [ x, y ] ) }
          if r.nil?
            rr = obj[:headline][:default]
          else
            rr = r

            [ :content, :text_color].each do | kk |
              keys = rr[ kk ].to_s.split( '__' ).map { | a | a.to_sym }
              rr[ kk ] = self.get_value( keys, obj, false )
            end
          end

          cell = Prawn::Table::Cell::Text.new( 
            pdf, 
            [ 0, 0 ], 
            content: rr[:content], 
            inline_format: true, 
            borders: rr[:borders],
            border_width: rr[:border_width],
            text_color: rr[:text_color],
            align: rr[:align]
          )

          row.push( cell )
        end
      end
      data.push( row )
    end
    
    pdf.table( 
      data, 
      cell_style: { 
        size: obj[:style][:font][:small],
        height: h[:grid][:height][:cell]
      },
      width: h[:grid][:width][:total]
    )
    return pdf
  end

    
  def pdf_generate_two( obj, pdf )    
    pdf.font obj[:style][:font][:name]
    offset_x = obj[:style][:address_label][:offset_x]

    pdf.text_box( 
      obj[:sections][:two][:small][:content], 
      at: [ pdf.bounds.left + offset_x, pdf.cursor], 
      width: 400, 
      height: 200, 
      overflow: :expand, 
      inline_format: true,
      size: obj[:style][:font][:small]
    )

    pdf.move_down obj[:style][:address_label][:move_down_one]

    pdf.text_box(
      obj[:sections][:two][:to][:content],
      at: [ pdf.bounds.left + offset_x , pdf.cursor], 
      width: 400, 
      height: 200, 
      overflow: :expand, 
      inline_format: true,
      size: obj[:style][:font][:default]
    ) 

    pdf.move_down obj[:style][:address_label][:move_down_two]

    return pdf
  end
    
    
  def pdf_generate_three( obj, pdf )
    pdf.font( obj[:style][:font][:name] )

    pdf.text( 
      obj[:sections][:three][:date][:content], 
      inline_format: true,
      size: obj[:style][:font][:default]
    )
    pdf.text( 
      obj[:sections][:three][:headline][:content], 
      inline_format: true,
      size: obj[:style][:font][:default]
    )
    
    cpos = pdf.cursor

    if obj[:show][:qr_code]
      x = obj[:style][:articles]
        .keys
        .map { | key | obj[:style][:articles][ key ][:width] }
        .sum + 10

      pdf.print_qr_code( 
        obj[:sections][:three][:qr_code][:content], 
        pos: [ x - obj[:style][:qr_code][:width] , cpos + obj[:style][:qr_code][:width] ], 
        extent: obj[:style][:qr_code][:width], 
        stroke: false 
      )
    end

    return pdf
  end
    
    
  def pdf_generate_four( obj, pdf )
    pdf.font( obj[:style][:font][:name] )
    pdf.text( 
      obj[:sections][:four][:snippet][:content], 
      inline_format: true,
      size: obj[:style][:font][:default]
    )

    return pdf
  end
    
    
  def pdf_generate_five( obj, pdf )
    table_data = []
    row = []

    cells = obj[:text][:articles].zip( obj[:style][:articles] )
      .map { | text, style | { name: text[ 1 ] }.merge( style[ 1 ] ) }

    cells.each do | cell |
      c = Prawn::Table::Cell::Text.new( 
        pdf, 
        [ 0, 0 ], 
        content: cell[:name], 
        inline_format: true, 
        borders: [ :bottom ],
        align: cell[:align],
        width: cell[:width],
      )
      row.push( c )
    end
    table_data.push( row )
    
    obj[:items][:articles].each.with_index do | article, index |
      contents = [ index + 1, :id, :name, :pieces, :single, :total ].map do | key |
        if key.class.to_s.eql?( 'Integer' )
          key.to_s
        else
          keys = key.to_s.split( '__' ).map { | a | a.to_sym }
          case keys.length
          when 1
            article[ keys[ 0 ] ].to_s
          when 2
            article[ keys[ 0 ] ][ keys[ 1 ] ].to_s
          end
        end
      end

      row = []
      contents.each.with_index do | text, i |
        c = Prawn::Table::Cell::Text.new( 
          pdf, 
          [ 0, 0 ], 
          content: text, 
          inline_format: true, 
          border_width: 0,
          align: cells[ i ][:align],
          width: cells[ i ][:width],
        )
        row.push( c )
      end

      table_data.push( row )
    end

    pdf.table( 
      table_data, 
      cell_style: { size: obj[:style][:font][:default] }, 
      width: obj[:style][:document][:width], 
      row_colors: obj[:style][:colors][:rows].values
    )

    return pdf
  end
    
    
  def pdf_generate_six( obj, pdf )  
    table_data = []
    orders = obj[:text][:total].keys
    articles = obj[:style][:articles].keys

    grid = orders.map do | order |
      articles.map do | article |
        {
          text: '',
          width: obj[:style][:articles][ article ][:width],
          align: obj[:style][:articles][ article ][:align],
          borders: [:top],
          border_width: 0
        }
      end
    end

    items = orders.map.with_index do | key, index |
      item = {}
      item[:show] = obj[:show][ key ]
      item[:y] = index
      item[:text] = obj[:text][:total][ key ]
      item[:value] = obj[:sections][:six][ key ][:content]
      item[:borders] = obj[:style][:total][ key ][:borders]
      item[:border_width] = obj[:style][:total][ key ][:border_width]
      item
    end

    items.each.with_index do | item, y |
      if item[:show]
        item.keys.each do | key |
          [ 3, 4, 5 ].each do | type |
            grid[ y ][ type ][ key ] = item[ key ]
            case type
            when 3
              grid[ y ][ type ][:insert] = item[:text]
            when 4
              grid[ y ][ type ][:insert] = ''
            when 5
              grid[ y ][ type ][:insert] = item[:value]
            end
          end
        end
      end
    end

    grid.each do | _row |
      row = []
      _row.each do | cell |
        c = Prawn::Table::Cell::Text.new( 
          pdf, 
          [ 0, 0 ], 
          content: cell[:insert].to_s, 
          inline_format: true, 
          borders: cell[:borders],
          border_widths: cell[:border_width],
          align: cell[:align],
          width: cell[:width]
        )
        row.push( c )
      end
      table_data.push( row )
    end

    if table_data.length != 0
      pdf.table( 
        table_data, 
        cell_style: { size: obj[:style][:font][:default] }, 
        width: obj[:style][:document][:width]
      )
    end

    return pdf  
  end
    
    
  def pdf_generate_seven( obj, pdf )
    pdf.font( obj[:style][:font][:name] )
    pdf.text( 
      obj[:sections][:seven][:snippet][:content], 
      inline_format: true,
      size: obj[:style][:font][:default]
    )

    return pdf
  end
    
    
  def pdf_generate_eight( obj, pdf )
    pdf.font( obj[:style][:font][:name] )
    pdf.text( 
      obj[:sections][:eight][:snippet][:content], 
      inline_format: true,
      size: obj[:style][:font][:default]
    )
    
    return pdf
  end
    

  def pdf_generate_nine( obj, pdf, p )
    x = obj[:style][:articles]
      .keys
      .map { | key | obj[:style][:articles][ key ][:width] }
      .sum

    measure = "#{p[:page]} / #{p[:total]}"
    
    offset = pdf
      .font( obj[:style][:font][:name] )
      .compute_width_of( measure, size: obj[:style][:font][:small] )

    options = { 
      at: [ x - offset, pdf.bounds.height + obj[:style][:page_count][:offset_y] ],
      size: obj[:style][:font][:small],
      start_count_at: obj[:style][:page_count][:start_count_at]
    }

    pdf.go_to_page( p[:index] + 1 )
    pdf.draw_text( measure, options )

    return pdf
  end

              
  def pdf_generate_footer( obj, pdf )

    table_data = []
    aligns = obj[:footer].keys

    headlines = [ 
      :sections__nine__left_headline__content,
      :sections__nine__center_headline__content,
      :sections__nine__right_headline__content
    ]
    headlines = headlines.map do | a | 
      keys = a.to_s.split( '__' ).map { | a | a.to_sym }
      self.get_value( keys, obj, false )
    end

    row = []

    for i in 0..headlines.length - 1
      # str = headlines[ i ]
      c = Prawn::Table::Cell::Text.new( 
        pdf, 
        [ 0, 0 ], 
        content: '-', 
        inline_format: true, 
        borders: obj[:style][:footer][:borders],
        border_width: obj[:style][:footer][:border_width],
        text_color: obj[:style][:colors][:background],
        align: aligns[ i ],
        padding: 0
      )
      row.push( c )    
    end

    table_data.push( row )
    row = []

    for i in 0..headlines.length - 1
      str = headlines[ i ]
      c = Prawn::Table::Cell::Text.new( 
        pdf, 
        [ 0, 0 ], 
        content: str, 
        inline_format: true, 
        border_width: 0,
        align: aligns[ i ],
        padding: 0
      )
      row.push( c )    
    end

    table_data.push( row )
    combs = []

    obj[:footer].keys.each { | h |
      obj[:footer][ h ].keys.each { | v |
        combs.push( [ h, v ] )
      }
    }

    rows = combs
      .map { | a | a[ 1 ] }.to_set.to_a
      .map { | key | combs.select { | cell | cell[ 1 ] == key } }

    rows.each do | _row |
      row = []
      _row.each do | _cell |
        keys = obj[:footer][ _cell[ 0 ] ][ _cell[ 1 ] ]
          .to_s.split( '__' )
          .map { | a | a.to_sym }

        str = get_value( keys, obj, false )
        c = Prawn::Table::Cell::Text.new( 
          pdf, 
          [ 0, 0 ], 
          content: str, 
          inline_format: true, 
          border_width: 0,
          align: _cell[ 0 ],
          padding: 0
        )
        row.push( c )
      end
      table_data.push( row )
    end

    pdf.table( 
      table_data, 
      cell_style: { size: obj[:style][:font][:small] }, 
      width: obj[:style][:document][:width]
    )

    return pdf
  end

end