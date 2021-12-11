require '../lib/write_invoice'
#require 'digest'

payload = WriteInvoice::Example.generate()
options = {
    show__logo: true,
    headline__image__src: "#{Dir.pwd}/template/logo.png",
    show__unencrypted: false
}

WriteInvoice::Document.generate( 
    output: 'original/original.pdf', 
    payload: payload, 
    options: options
)

File.open( 'original/payload.json', 'w') { | f | f.write( JSON.pretty_generate( payload ) ) }