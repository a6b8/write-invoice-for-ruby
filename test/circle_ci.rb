require './lib/write_invoice'
require 'digest'

require 'net/http'
require 'base64'

path_payload = './test/original/payload.json'
path_original = './test/original/original.pdf'

file = File.read( path_payload )
payload = JSON.parse( file ) 

url = "https://docs.writeinvoice.com/assets/images/logo.png"
uri = URI( url )
response = Net::HTTP.get( uri )
file = Base64.encode64( response )

tests = [
    {
        name: 'Test sameness',
        expect: true, 
        options: {
            show__logo: true,
            headline__image__src: file,
            show__unencrypted: false
        }
    },
    {
        name: 'Test diffrence',
        expect: false,
        options: {
            show__logo: true,
            headline__image__src: file,
            show__unencrypted: true
        }
    }
]

original = File.read( path_original )
first = Digest::SHA256.hexdigest( original )

puts "TESTS:"
results = []
tests.each.with_index do | test, index |
    duplicate = WriteInvoice::Document.generate( 
        payload: payload,
        options: test[:options],
        debug: false
    )
    second = Digest::SHA256.hexdigest( duplicate )
    compare = first.eql?( second )
    
    puts "  [#{index}]            #{test[:name]}"
    puts "  Original:      #{first}"
    puts "  Duplicate:     #{second}"
    puts "  Result:        #{compare}"
    puts "  Expect:        #{test[:expect]}"
    puts

    result = compare.eql? test[:expect]
    results.push( result )
end

final = results.all?
puts "Overall: #{final}"

final ? exit( 0 ) : exit( 1 )