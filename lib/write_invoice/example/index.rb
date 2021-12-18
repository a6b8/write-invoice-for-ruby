module Exmple
  private


  def examples_generate( invoices_total: nil, articles_total: nil )
    struct = {
      document: {
        metadata: {
          title: '',
          author: '',
          subject: ''
        },
        encrypt: {
          user_password: '',
          owner_password: '',
          permissions: {
            print_document: nil,
            modify_contents: nil,
            copy_contents: nil,
            modify_annotations: nil
          }     
        }
      },
      invoices: []
    }

    results = []
    rand( invoices_total ).times.each.with_index do | t, index |
      payload = example_generate( articles_total: articles_total )

      if index == 0
          results.push( payload )
      else
      [ :address, :bank, :contact, :tax_id ].each do | key | 
          payload[:from][ key ] = results[ 0 ][:from][ key ]
      end

      results.push( payload )
      end
    end

    struct[:document][:metadata][:title] = results[ 0 ][:from][:address][:name]
    struct[:document][:metadata][:author] = 'This is a Demo Document.'
    struct[:document][:metadata][:subject] = 'Ecommerce Revenue'

    alpha = [ ( 'a'..'z' ), ( 'A'..'Z' ), ( '0'..'9' ) ].map( &:to_a ).flatten
    struct[:document][:encrypt][:user_password] = ( 0...42 ).map { alpha[ rand( alpha.length ) ] }.join
    struct[:document][:encrypt][:owner_password] = struct[:document][:encrypt][:user_password]
    struct[:document][:encrypt][:permissions][:print_document] = true
    struct[:document][:encrypt][:permissions][:modify_contents] = false
    struct[:document][:encrypt][:permissions][:copy_contents] = false
    struct[:document][:encrypt][:permissions][:modify_annotations] = false

    struct[:invoices] = results
        .sort_by { | a | a[:to][:address][:name] }

    return struct
  end


  private


  def example_generate( articles_total: nil )
    template = {
      structure: {
        meta: {
          id: '',
          qr_code: '',
          headline: '',
          group: ''
        },
        date: {
          period: {
          from: '',
          to: ''
          },
          invoice: '',
          billing: ''
        },
        from: {
          address: {
            name: '',
            phrase: '',
            street: '',
            city: '',
            country: ''
          },
          bank: {
            name: '',
            iban: '',
            bic: ''
          },
          contact: {
            phone: '',
            mobile: '',
            email: '',
            website: ''
          },
          tax_id: ''
        },
        to: {
          address: {
            name: '',
            street: '',
            city: '',
            country: ''
          },
          tax_id: ''
        },
        items: {
          articles: [],
          sub_total: nil,
          shipping_fee: nil,
          total_net: nil,
          vat: nil,
          total_gross: nil
        }
      }
    }

    config = {
      domain: 'writeinvoice.com',
      date: {
        from: '1998-01-01',
        to: '1998-01-30'
      },
      days: {
        invoice: 15,
        billing: 30
      }
    }
    
    payload = Marshal.load( Marshal.dump( template[:structure] ) )
    payload[:date][:period][:from] = 
      Faker::Date.between( from: config[:date][:from], to: config[:date][:to] ).to_time.to_i
    
    tmp = Faker::Date.between( from: config[:date][:from], to: config[:date][:to] )
    payload[:date][:period][:to] = tmp.to_time.to_i
    payload[:date][:invoice] = tmp.next_day( config[:days][:invoice] ).to_time.to_i
    payload[:date][:billing] = tmp.next_day( config[:days][:billing] ).to_time.to_i
    
    payload[:from][:address][:name] = Faker::Movies::Hobbit.character 
    payload[:from][:address][:phrase] = Faker::Company.catch_phrase
    payload[:from][:address][:street] = Faker::Address.street_address
    payload[:from][:address][:city] = "#{Faker::Address.zip} #{Faker::Address.city}"
    payload[:from][:address][:country] = Faker::Movies::StarWars.planet
    
    payload[:from][:bank][:name] = Faker::Company.name
    payload[:from][:bank][:iban] = Faker::Bank.iban
    payload[:from][:bank][:bic] = Faker::Bank.swift_bic
    
    payload[:from][:contact][:phone] = Faker::PhoneNumber.phone_number
    payload[:from][:contact][:mobile] = Faker::PhoneNumber.phone_number
    payload[:from][:contact][:email] = Faker::Internet.email( domain: config[:domain] )
    payload[:from][:contact][:website] = Faker::Internet.domain_name( subdomain: true, domain: config[:domain] )
    
    payload[:from][:tax_id] = Faker::IDNumber.valid
    
    payload[:to][:address][:name] = Faker::Movies::StarWars.character
    payload[:to][:address][:street] = Faker::Address.street_address
    payload[:to][:address][:city] = "#{Faker::Address.zip} #{Faker::Address.city}"
    payload[:to][:address][:country] = Faker::Movies::StarWars.planet
    
    payload[:to][:tax_id] = Faker::IDNumber.valid

    payload[:meta][:id] = Faker::DrivingLicence.usa_driving_licence 
    payload[:meta][:qr_code] = "https://#{payload[:from][:contact][:website]}/api/#{payload[:meta][:id]}" 
    payload[:meta][:headline] = "#{payload[:meta][:id]} | #{payload[:to][:address][:name]}"
    payload[:meta][:group] = DateTime.strptime( payload[:date][:billing].to_s,  '%s' ).strftime( '%G-W%V' )

    rand( articles_total ).times.each do | index |
      article =  {
        id: '', 
        name: '',
        pieces: nil,
        single: nil,
        total: nil
      }

      article[:id] = Faker::IDNumber.valid
      article[:name] = Faker::Commerce.product_name
      _p = rand( 1..5 )
      article[:pieces] = _p
      _n = Faker::Commerce.price
      article[:single] = _n
      article[:total] = ( _n * _p ).round( 2 )
      payload[:items][:articles].push( article )
    end
    
    payload[:items][:sub_total] = payload[:items][:articles].map { | a | a[:total] }.sum
    payload[:items][:shipping_fee] = Faker::Commerce.price( range: 0..10.0 )
    payload[:items][:total_net] = ( payload[:items][:sub_total] + payload[:items][:shipping_fee] ).round( 2 )
    payload[:items][:total_gross] = ( payload[:items][:total_net] * 1.19 ).round( 2 )
    payload[:items][:vat] = ( payload[:items][:total_gross] - payload[:items][:total_net] ).round( 2 )

    return payload
  end

end