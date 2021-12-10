require '../lib/write_invoice'

pp = WriteInvoice::Example.generate()
opts = {}

WriteInvoice::Document.generate( output: 'test.pdf', payload: pp, options: opts )