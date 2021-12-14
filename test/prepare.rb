require '../lib/write_invoice'
require 'base64'
#require 'digest'

url = "https://docs.writeinvoice.com/assets/images/logo.png"
uri = URI( url )
response = Net::HTTP.get( uri )
image = Base64.encode64( response )


payload = WriteInvoice::Example.generate()
options = {
    show__logo: true,
    headline__image__src: image,
    show__unencrypted: false
}

WriteInvoice::Document.generate( 
    output: 'original/original.pdf', 
    payload: payload, 
    options: options
)

File.open( 'original/payload.json', 'w') { | f | f.write( JSON.pretty_generate( payload ) ) }