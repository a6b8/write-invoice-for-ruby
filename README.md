<a href="#table-of-contents">
<img src="https://raw.githubusercontent.com/a6b8/a6b8/main/assets/headlines/custom/write-invoice-for-ruby.svg" height="45px" name="# Write Invoice for Ruby" alt="Write Invoice for Ruby"><br>
</a>

`write_invoice` is a ruby gem to generate multiple invoices in one document.
<br>
<br>
<a href="#table-of-contents">
<img src="https://raw.githubusercontent.com/a6b8/a6b8/main/assets/headlines/default/examples.svg" height="38px" name="Examples" alt="Examples">
   
> **Visit**: [docs.writeinvoice.com](https://docs.writeinvoice.com)  

</a>

<br>
<a href="#headline">
<img src="https://raw.githubusercontent.com/a6b8/a6b8/main/assets/headlines/default/table-of-contents.svg" height="38px" name="table-of-contents" alt="Table of Contents">
</a>
<br>

1. [Examples](#examples)<br>
2. [Quickstart](#quickstart)<br>
3. [Setup](#setup)<br>
4. [String Modification](#string-modification)<br>
5. [Contributing](#contributing)<br>
6.  [Limitations](#limitations)<br>
7.  [Credits](#credits)<br>
8.  [License](#license)<br>
9.  [Code of Conduct](#code-of-conduct)<br>
10. [Support my Work](#support-my-work)<br>

<br>

<a href="#table-of-contents">
<img src="https://raw.githubusercontent.com/a6b8/a6b8/main/assets/headlines/default/quickstart.svg" height="38px" name="quickstart" alt="Quickstart">
</a>

```ruby
require 'write_invoice'

pyld = WriteInvoice::Example.generate()
WriteInvoice::Document.generate( output: 'test.pdf', payload: pyld, options: {}, debug: true )
```
<br>

<a href="#table-of-contents">
<img src="https://raw.githubusercontent.com/a6b8/a6b8/main/assets/headlines/default/setup.svg" height="38px" name="setup" alt="Setup">
</a>

Add this line to your application's Gemfile:

```ruby
gem 'write_invoice'
```

And then execute:

    $ bundle install

Or install it yourself as:

    $ gem install write_invoice


On Rubygems: 
- Gem: https://rubygems.org/gems/write_invoice
- Profile: https://rubygems.org/profiles/a6b8

<br>

<a href="#table-of-contents">
<img src="https://raw.githubusercontent.com/a6b8/a6b8/main/assets/headlines/default/contributing.svg" height="38px" name="contributing" alt="Contributing">
</a>

Bug reports and pull requests are welcome on GitHub at https://github.com/a6b8/write-invoice-for-ruby. This project is intended to be a safe, welcoming space for collaboration, and contributors are expected to adhere to the [code of conduct](https://github.com/a6b8/write-invoice-for-ruby/blob/master/CODE_OF_CONDUCT.md).

<br>

<a href="#table-of-contents">
<img src="https://raw.githubusercontent.com/a6b8/a6b8/main/assets/headlines/default/limitations.svg" height="38px" name="limitations" alt="Limitations">
</a>

- Not battle tested with diffrent layouts.
  
<br>

<a href="#table-of-contents">
<img src="https://raw.githubusercontent.com/a6b8/a6b8/main/assets/headlines/default/credits.svg" height="38px" name="credits" alt="Credits">
</a>

- [prawn-table](https://github.com/prawnpdf/prawn-table)
- [prawn](https://prawnpdf.org/api-docs/2.3.0/)
- [prawn-qrcode](https://github.com/jabbrwcky/prawn-qrcode)
- [date](https://ruby-doc.org/stdlib-3.1.0/libdoc/date/rdoc/Date.html)
- [faker](https://github.com/faker-ruby/faker)
- [activesupport](https://rubygems.org/gems/activesupport)

<br>

<a href="#table-of-contents">
<img src="https://raw.githubusercontent.com/a6b8/a6b8/main/assets/headlines/default/license.svg" height="38px" name="license" alt="License">
</a>

The gem is available as open source under the terms of the [MIT License](https://opensource.org/licenses/MIT).

<br>

<a href="#table-of-contents">
<img src="https://raw.githubusercontent.com/a6b8/a6b8/main/assets/headlines/default/code-of-conduct.svg" height="38px" name="code-of-conduct" alt="Code of Conduct">
</a>
    
Everyone interacting in the write-invoice-for-ruby project's codebases, issue trackers, chat rooms and mailing lists is expected to follow the [code of conduct](https://github.com/a6b8/write-invoice-for-ruby/blob/master/CODE_OF_CONDUCT.md).

<br>

<a href="#table-of-contents">
<img href="#table-of-contents" src="https://raw.githubusercontent.com/a6b8/a6b8/main/assets/headlines/default/support-my-work.svg" height="38px" name="support-my-work" alt="Support my Work">
</a>
    
Donate by [https://www.paypal.com](https://www.paypal.com/donate?hosted_button_id=XKYLQ9FBGC4RG)