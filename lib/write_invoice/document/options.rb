
module Options


  def get_options()
    return {
      show: {
        qr_code: true,
        sub_total: true,
        shipping: true,
        total_net: true,
        vat: true,
        total_gross: true,
        logo: false,
        watermark: true,
        unencrypted: true
      },
      order: [
        { name: :header, move_down: [ 0 ] },
        { name: :two, move_down: [ :style__sections__pad ] },
        { name: :three, move_down: [ :style__sections__pad ] },
        { name: :four, move_down: [ :style__sections__pad, :style__sections__pad ] },
        { name: :five, move_down: [ :style__sections__pad, :style__sections__pad ] },
        { name: :six, move_down: [ 0 ] },
        { name: :seven, move_down: [ :style__sections__pad, :style__sections__pad ] },
        { name: :eight, move_down: [ :style__sections__pad ] }
      ],
      text: {
        phone: 'Phone:',
        mobile: 'Mobil:',
        email: 'Email:',
        website: 'Website:',
        tax_id: 'Tax ID:',
        invoice: 'Invoice',
        page_count: '<page> / <total>',
        articles: {
          nr: '<b>NR</b>',
          id: '<b>ID</b>',
          article: '<b>ARTICLE</b>',
          piece: '<b>PIECE</b>',
          single: '<b>SINGLE</b>',
          total: '<b>TOTAL</b>'
        },
        total: {
          sub_total: 'Subtotal:',
          shipping: '+ Shipping',
          total_net: '<b>Total (net):</b>',
          vat: '+ VAT 19 %',
          total_gross: '<b>Total (gross):</b>'
        },
        footer: {
          left: 'Postal',
          center: 'Bank',
          right: 'Contact'
        },
        watermark: 'Example'
      },
      style: {
        document: {
          format: 'A4',
          width: nil
        },
        page_count: {
          align: :right,
          start_count_at: 1,
          offset_y: 0
        },
        font: {
          family: {},
          name: 'Helvetica',
          default: 10,
          small: 8
        },
        colors: {
          background: 'FFFFFF',
          header: {
            default: '000000',
          },
          rows: {
            even: "F0F0F0",
            odd: "FFFFFF"
          }
        },
        header: {
          height: 90,
        },
        address_label: {
          offset_x: 20,
          move_down_one: 15,
          move_down_two: 100
        },
        footer: {
          height: 60,
          border_width: 1,
          borders: [ :top ]
        },
        sections: {
          pad: 10
        },
        articles: {
          nr: {
            align: :left,
            width: 40
          },
          id: {
            align: :left,
            width: 60
          },
          article: {
            align: :left,
            width: 220
          },
          piece: {
            align: :right,
            width: 80
          },
          single: {
            align: :right,
            width: 60,
            format: :format_types__currency__short
          },
          total: {
            align: :right,
            width: 60,
            format: :format_types__currency__short
          }
        },
        total: {
          sub_total: {
            borders: [ :top ],
            border_width: 1
          },
          shipping: {
            borders: [ :top ],
            border_width: 0
          },
          total_net: {
            borders: [ :top ],
            border_width: 1
          },
          vat: {
            borders: [ :top ],
            border_width: 0
          },
          total_gross: {
            borders: [ :top ],
            border_width: 0
          }
        },
        qr_code: {
          width: 40
        },
        watermark: {
          rotate: 45,
          fill_color: '383838',
          font_size: 180,
          font_family: 'Times-Roman',
          transparency: 0.1,
        }
      },
      format_types: {
        currency: {
          short: {
            delimiter: '.',
            separator: ',',
            precision: 2,
            unit: '',
            format: '%n €'
          },
          long: {
            delimiter: '.',
            separator: ',',
            precision: 2,
            unit: '',
            format: '%n EUR'
          }
        },
        date: {
          eu: {
            strf: '%d.%m.%Y'
          },
          short: {
            strf: '%B %d'
          },
          default: {
            strf: '%B %d, %Y'
          },
          long: {
            strf: '%A %B %d %Y %I:%M%P UTC'
          },
          year: {
            strf: '%Y'
          }
        }
      },
      sections: {
        nine: {
          left_headline: {
            content: nil,
            struct: '<b><<--a-->></b>',
            assigns: [
              {
                value: :obj__text__footer__left,
                format: nil
              }
            ]
          },
          left_one: {
            content: nil,
            struct: '<<--a-->>',
            assigns: [
              { 
                value: :payload__from__address__name,
                format: nil
              }
            ]
          },
          left_two: {
            content: nil,
            struct: '<<--a-->>',
            assigns: [
              { 
                value: :payload__from__address__street,
                format: nil
              }
            ]
          },
          left_three: {
            content: nil,
            struct: '<<--a-->>',
            assigns: [
              { 
                value: :payload__from__address__city,
                format: nil
              }
            ]
          },
          left_four: {
            content: nil,
            struct: '<<--a-->>',
            assigns: [
              { 
                value: :payload__from__address__country,
                format: nil
              }
            ]
          },
          center_headline: {
            content: nil,
            struct: '<b><<--a-->></b>',
            assigns: [
              {
                value: :obj__text__footer__center,
                format: nil
              }
            ]
          },
          center_one: {
            content: nil,
            struct: '<<--a-->>',
            assigns: [
              { 
                value: :payload__from__bank__name,
                format: nil
              }
            ]
          },
          center_two: {
            content: nil,
            struct: '<<--a-->>',
            assigns: [
              { 
                value: :payload__from__bank__iban,
                format: nil
              }
            ]
          },
          center_three: {
            content: nil,
            struct: '<<--a-->>',
            assigns: [
              { 
                value: :payload__from__bank__bic,
                format: nil
              }
            ]
          },
          center_four: {
            content: nil,
            struct: '<b><<--a-->> <<--b-->></b>',
            assigns: [
              {
                value: :obj__text__tax_id,
                format: nil
              },
              { 
                value: :payload__from__tax_id,
                format: nil
              }
            ]
          },
          right_headline: {
            content: nil,
            struct: '<b><<--a-->></b>',
            assigns: [
              {
                value: :obj__text__footer__right,
                format: nil
              }
            ]
          },
          right_one: {
            content: nil,
            struct: '<<--a-->> <<--b-->>',
            assigns: [
              {
                value: :obj__text__phone,
                format: nil
              },
              { 
                value: :payload__from__contact__phone,
                format: nil
              }
            ]
          },
          right_two: {
            content: nil,
            struct: '<<--a-->> <<--b-->>',
            assigns: [
              {
                value: :obj__text__mobile,
                format: nil
              },
              { 
                value: :payload__from__contact__mobile,
                format: nil
              }
            ]
          },
          right_three: {
            content: nil,
            struct: '<<--a-->> <<--b-->>',
            assigns: [
              {
                value: :obj__text__email,
                format: nil
              },
              { 
                value: :payload__from__contact__email,
                format: nil
              }
            ]
          },
          right_four: {
            content: nil,
            struct: '<<--a-->> <<--b-->>',
            assigns: [
              {
                value: :obj__text__website,
                format: nil
              },
              { 
                value: :payload__from__contact__website,
                format: nil
              }
            ]
          },
        },
        eight: {
          snippet: {
            content: nil,
            struct: "Thank you for using <<--a-->> Services.\n\n\nSincerely,\n\n<<--a-->>",
            assigns: [
              {
                value: :payload__from__address__name,
                format: nil
              }
            ]          
          }
        },
        seven: {
          snippet: {
            content: nil,
            struct: ' We will debit your bank account for <b><<--a-->></b> on <<--b-->>. Please ensure you have sufficient funds in your bank account to avoid service disruptions.',
            assigns: [
              { 
                value: :payload__items__total_gross,
                format: :obj__format_types__currency__long
              },
              { 
                value: :payload__date__billing,
                format: :obj__format_types__date__long
              }
            ]          
          }
        },
        six: {
          sub_total: {
            content: nil,
            struct: '<<--a-->>',
            assigns: [
              {
                value: :payload__items__sub_total,
                format: :obj__format_types__currency__short
              }
            ]
          },
          shipping: {
            content: nil,
            struct: '<<--a-->>',
            assigns: [
              {
                value: :payload__items__shipping_fee,
                format: :obj__format_types__currency__short
              }
            ]
          },
          total_net: {
            content: nil,
            struct: '<b><<--a-->><b> ',
            assigns: [
              {
                value: :payload__items__total_net,
                format: :obj__format_types__currency__short
              }
            ]
          },
          vat: {
            content: nil,
            struct: '<<--a-->>',
            assigns: [
              {
                value: :payload__items__vat,
                format: :obj__format_types__currency__short
              }
            ]
          },
          total_gross: {
            content: nil,
            struct: '<b><<--a-->></b>',
            assigns: [
              {
                value: :payload__items__total_gross,
                format: :obj__format_types__currency__short
              }
            ]
          }
        },
        four: {
          snippet: {
            content: nil,
            struct: "Greetings from <<--a-->>,\n\nThis is a <u>demo invoice</u> for usage of <<--a-->> services for billing period <b><<--b-->> - <<--c-->></b>.",
            assigns: [
              { 
                value: :payload__from__address__name,
                format: nil
              },
              { 
                value: :payload__date__period__from,
                format: :obj__format_types__date__short
              },
              { 
                value: :payload__date__period__to,
                format: :obj__format_types__date__default
              }
            ]          
          }
        },
        three: {
          qr_code: {
            content: nil,
            struct: '<<--a-->>',
            assigns: [
              { 
                value: :payload__meta__qr_code,
                format: nil
              }
            ]
          },
          date: {
            content: nil,
            struct: '<<--a-->>',
            assigns: [
              { 
                value: :payload__date__invoice,
                format: :obj__format_types__date__eu
              }
            ]
          },
          headline: {
            content: nil,
            struct:  '<b><<--a-->> | <<--b-->></b>',
            assigns: [
              {
                value: :obj__text__invoice,
                format: nil
              },
              {
                value: :payload__meta__id,
                format: nil
              }
            ]
          } 
        },
        two: {
          small: {
            content: nil,
            struct: '<u><<--a-->> - <<--b-->> - <<--c-->></u>',
            assigns: [
              {
                value: :payload__from__address__name,
                format: nil
              },
              {
                value: :payload__from__address__street,
                format: nil
              },
              {
                value: :payload__from__address__city,
                format: nil
              }
            ]
          },
          to: {
            content: nil,
            struct: "\t\t<b><<--a-->></b>\n<<--b-->>\n<<--c-->>\nTax ID: <<--d-->>",
            assigns: [
              {
                value: :payload__to__address__name,
                format: nil
              },
              { 
                value: :payload__to__address__street,
                format: nil
              },
              {
                value: :payload__to__address__city,
                format: nil
              },
              {
                value: :payload__to__tax_id,
                format: nil
              }
            ]
          }
        },
        one: {
          name: {
            content: nil,
            struct: "<b><<--a-->></b>\n<<--b-->>\n<<--c-->>\n<<--d-->>",
            assigns: [
              { 
                value: :payload__from__address__name,
                format: nil
              },
              { 
                value: :payload__from__address__phrase,
                format: nil
              },
              { 
                value: :payload__from__address__city,
                format: nil
              },
              { 
                value: :payload__from__address__country,
                format: nil
              }
            ]
          }
        },
        custom: {}
      },
      headline: {
        grid: {
          x: 3,
          y: 1
        },
        default: {
          content: '', 
          style: :style__document__font_size__small,
          align: :right,
          text_color: :style__colors__header__default,
          borders: [ :left ],
          border_width: 2
        },
        image: {
          src: '',
          colspan: 2,
          rowspan: 2,
          grid: [ 0, 0 ],
          borders: [],
          fit: [ 160, 100 ],
          border_width: 0
        },
        texts: [
          { 
            content: :sections__one__name__content,
            grid: [ 2, 0 ],
            style: :style__document__font_size__h1,
            align: :right,
            text_color: :style__colors__header__default,
            borders: [ ],
            border_width: 0
          }
        ]
      },
      footer: {
        left: {
          one: :sections__nine__left_one__content,
          two: :sections__nine__left_two__content,
          three: :sections__nine__left_three__content,
          four: :sections__nine__left_four__content
        },
        center: {
          one: :sections__nine__center_one__content,
          two: :sections__nine__center_two__content,
          three: :sections__nine__center_three__content,
          four: :sections__nine__center_four__content
        },
        right: {
          one: :sections__nine__right_one__content,
          two: :sections__nine__right_two__content,
          three: :sections__nine__right_three__content,
          four: :sections__nine__right_four__content
        }
      },
      validation: {
        allows: [
          :show__qr_code,
          :show__sub_total,
          :show__shipping,
          :show__total_net,
          :show__vat,
          :show__total_gross,
          :show__logo,
          :show__watermark,
          :show__unencrypted,
          :order,
          :text__phone,
          :text__mobile,
          :text__email,
          :text__website,
          :text__tax_id,
          :text__invoice,
          :text__page_count,
          :text__articles__nr,
          :text__articles__id,
          :text__articles__article,
          :text__articles__piece,
          :text__articles__single,
          :text__articles__total,
          :text__total__sub_total,
          :text__total__shipping,
          :text__total__total_net,
          :text__total__vat,
          :text__total__total_gross,
          :text__footer__left,
          :text__footer__center,
          :text__footer__right,
          :text__watermark,
          :style__document__format,
          :style__page_count__align,
          :style__page_count__start_count_at,
          :style__page_count__offset_y,
          :style__font__name,
          :style__font__family,
          :style__font__default,
          :style__font__small,
          :style__colors__background,
          :style__colors__header__default,
          :style__colors__rows__even,
          :style__colors__rows__odd,
          :style__header__height,
          :style__address_label__offset_x,
          :style__address_label__move_down_one,
          :style__address_label__move_down_two,
          :style__footer__height,
          :style__footer__border_width,
          :style__footer__borders,
          :style__sections__pad,
          :style__articles__nr__align,
          :style__articles__nr__width,
          :style__articles__id__align,
          :style__articles__id__width,
          :style__articles__article__align,
          :style__articles__article__width,
          :style__articles__piece__align,
          :style__articles__piece__width,
          :style__articles__single__align,
          :style__articles__single__width,
          :style__articles__single__format,
          :style__articles__total__align,
          :style__articles__total__width,
          :style__articles__total__format,
          :style__total__sub_total__borders,
          :style__total__sub_total__border_width,
          :style__total__shipping__borders,
          :style__total__shipping__border_width,
          :style__total__total_net__borders,
          :style__total__total_net__border_width,
          :style__total__vat__borders,
          :style__total__vat__border_width,
          :style__total__total_gross__borders,
          :style__total__total_gross__border_width,
          :style__qr_code__width,
          :style__watermark__rotate,
          :style__watermark__fill_color,
          :style__watermark__font_size,
          :style__watermark__font_family,
          :style__watermark__transparency,
          :format_types__currency__short,
          :format_types__currency__long,
          :format_types__date__eu,
          :format_types__date__short,
          :format_types__date__default,
          :format_types__date__long,
          :format_types__date__year,
          :sections__nine__left_headline,
          :sections__nine__left_one,
          :sections__nine__left_two,
          :sections__nine__left_three,
          :sections__nine__left_four,
          :sections__nine__center_headline,
          :sections__nine__center_one,
          :sections__nine__center_two,
          :sections__nine__center_three,
          :sections__nine__center_four,
          :sections__nine__right_headline,
          :sections__nine__right_one,
          :sections__nine__right_two,
          :sections__nine__right_three,
          :sections__nine__right_four,
          :sections__eight__snippet,
          :sections__seven__snippet,
          :sections__six__sub_total,
          :sections__six__shipping,
          :sections__six__total_net,
          :sections__six__vat,
          :sections__six__total_gross,
          :sections__four__snippet,
          :sections__three__qr_code,
          :sections__three__date,
          :sections__three__headline,
          :sections__two__small,
          :sections__two__to,
          :sections__one__name,
          :headline__grid__x,
          :headline__grid__y,
          :headline__default__content,
          :headline__default__style,
          :headline__default__align,
          :headline__default__text_color,
          :headline__default__borders,
          :headline__default__border_width,
          :headline__image__src,
          :headline__image__colspan,
          :headline__image__rowspan,
          :headline__image__grid,
          :headline__image__borders,
          :headline__image__fit,
          :headline__image__border_width,
          :headline__texts,
          :footer__left__one,
          :footer__left__two,
          :footer__left__three,
          :footer__left__four,
          :footer__center__one,
          :footer__center__two,
          :footer__center__three,
          :footer__center__four,
          :footer__right__one,
          :footer__right__two,
          :footer__right__three,
          :footer__right__four
        ],
        wildcards: []
      }
    }
  end

  
  private
  

  def options_update( options, obj, validation )
    def str_difference( a, b )
      a = a.to_s.downcase.split( '_' ).join( '' )
      b = b.to_s.downcase.split( '_' ).join( '' )
      longer = [ a.size, b.size ].max
      same = a
        .each_char
        .zip( b.each_char )
        .select { | a, b | a == b }
        .size
      ( longer - same ) / a.size.to_f
    end
  
  
    allows = obj[:validation][:allows]
    wildcards = obj[:validation][:wildcards]
  
    messages = []
    insert = Marshal.load( Marshal.dump( obj ) )

    options.keys.each do | key |
      if allows.include?( key ) 
  
        keys = key.to_s.split( '__' ).map { | a | a.to_sym }
        case( keys.length )
          when 1
            insert[ keys[ 0 ] ] = options[ key ]
          when 2
            insert[ keys[ 0 ] ][ keys[ 1 ] ] = options[ key ]
          when 3
            insert[ keys[ 0 ] ][ keys[ 1 ] ][ keys[ 2 ] ] = options[ key ]
          when 4
            insert[ keys[ 0 ] ][ keys[ 1 ] ][ keys[ 2 ] ][ keys[ 3 ] ] = options[ key ]
        end
      else 
        standard = true
        keys = key.to_s.split( '__' ).map { | a | a.to_sym }
        case keys.length
          when 1
            inside = wildcards
              .map { | a | a.to_s.split( '__' ).first.to_sym }
              .include?( keys[ 0 ] )
  
            if inside
              message = "\"#{key}\" is a potential Wildcard key but has an invalid length. Use two additional keys (plus '__') to set your option."
              messages.push( message )
              standard = false
            else
            end
          when 2..3
            wildcard = [ keys[ 0 ].to_s, keys[ 1 ].to_s ].join( '__' ).to_sym
            if wildcards.include?( wildcard )
              if keys.length == 2
                message = "\"#{key}\" is a Wildcard key but has an invalid length. Use an additional key (plus '__') to set your option."
                messages.push( message )
                standard = false
              else
                !insert.keys.include?( keys[ 0 ] ) ? insert[ keys[ 0 ] ] = {} : ''
                !insert[ keys[ 0 ] ].keys.include?( keys[ 1 ] ) ? insert[ keys[ 0 ] ][ keys[ 1 ] ] = {} : ''
                insert[ keys[ 0 ] ][ keys[ 1 ] ][ keys[ 2 ] ] = options[ key ]
                standard = false
              end
            else
            end
        else
        end
  
        if standard
          nearest = allows
            .map { | word | { score: str_difference( key, word ), word: word } }
            .min_by { | item | item[:score] }

          if nearest.nil?
            message =  "\"#{key}\" is not a valid key."
          else
            message = "\"#{key}\" is not a valid key, did you mean \"<--similar-->\"?"
            message = message.gsub( '<--similar-->', nearest[:word].to_s )
          end

          messages.push( message )
        end
      end
    end
  
    if messages.length != 0
      messages.length == 1 ? puts( 'Error found:' ) : puts( 'Errors found:' ) 
      messages.each { | m | puts( '- ' + m ) }
    end

    
    if validation
      return [ messages.length == 0, messages ]
    else
      return insert
    end
  end
  
  
  def get_value( keys, data, drop )

    drop ? keys = keys.drop( 1 ) : ''
    case keys.length
      when 1
        params = data[ keys[ 0 ] ]
      when 2
        params = data[ keys[ 0 ] ][ keys[ 1 ] ]
      when 3
        params = data[ keys[ 0 ] ][ keys[ 1 ] ][ keys[ 2 ] ]
      when 4
        params = data[ keys[ 0 ] ][ keys[ 1 ] ][ keys[ 2 ] ][ keys[ 3 ] ]
      when 5
        params = data[ keys[ 0 ] ][ keys[ 1 ] ][ keys[ 2 ] ][ keys[ 3 ] ][ keys[ 4 ] ]
    end

    return params
  end
  
  
  def get_format( type, value, _format )
    case type 
      when :date 
        result = DateTime.strptime( value.to_s, '%s' )
          .strftime( _format[:strf] )
      when :currency
        result =  ActiveSupport::NumberHelper
          .number_to_currency( value.to_s, _format )
      else
        result = value
    end

    return result
  end

end
