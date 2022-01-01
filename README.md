<a href="#table-of-contents">
<img src="https://raw.githubusercontent.com/a6b8/a6b8/main/docs/write-invoice-for-ruby/readme/headlines/headline.svg" height="45px" name="# Invoice Builder for Ruby" alt="Invoice Builder for Ruby"><br>
</a>

`write_invoice` is a ruby gem to generate multiple invoices in one document.
<br>
<br>
<a href="#table-of-contents">
<img src="https://raw.githubusercontent.com/a6b8/a6b8/main/docs/write-invoice-for-ruby/readme/headlines/documentation.svg" height="38px" name="Documentation" alt="documentation">

Visit: [docs.writeinvoice.com](https://docs.writeinvoice.com)
</a>
<br>
<br>
<a href="#headline">
<img src="https://raw.githubusercontent.com/a6b8/a6b8/main/docs/write-invoice-for-ruby/readme/headlines/table-of-contents.svg" height="38px" name="table-of-contents" alt="Table of Contents">
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
<img src="https://raw.githubusercontent.com/a6b8/a6b8/main/docs/write-invoice-for-ruby/readme/headlines/quickstart.svg" height="38px" name="quickstart" alt="Quickstart">
</a>

```ruby
require 'write_invoice'

pyld = WriteInvoice::Example.generate()
WriteInvoice::Document.generate( output: 'test.pdf', payload: pyld, options: {}, debug: true )
```
<br>

<a href="#table-of-contents">
<img src="https://raw.githubusercontent.com/a6b8/a6b8/main/docs/local-path-builder-for-ruby/readme/headlines/setup.svg" height="38px" name="setup" alt="Setup">
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
<img src="https://raw.githubusercontent.com/a6b8/a6b8/main/docs/write-invoice-for-ruby/readme/headlines/contributing.svg" height="38px" name="contributing" alt="Contributing">
</a>

Bug reports and pull requests are welcome on GitHub at https://github.com/a6b8/write-invoice-for-ruby. This project is intended to be a safe, welcoming space for collaboration, and contributors are expected to adhere to the [code of conduct](https://github.com/a6b8/write-invoice-for-ruby/blob/master/CODE_OF_CONDUCT.md).

<br>

<a href="#table-of-contents">
<img src="https://raw.githubusercontent.com/a6b8/a6b8/main/docs/write-invoice-for-ruby/readme/headlines/limitations.svg" height="38px" name="limitations" alt="Limitations">
</a>

- write_invoice
  
<br>

<a href="#table-of-contents">
<img src="https://raw.githubusercontent.com/a6b8/a6b8/main/docs/write-invoice-for-ruby/readme/headlines/credits.svg" height="38px" name="credits" alt="Credits">
</a>

- write_invoice

<br>

<a href="#table-of-contents">
<img src="https://raw.githubusercontent.com/a6b8/a6b8/main/docs/write-invoice-for-ruby/readme/headlines/license.svg" height="38px" name="license" alt="License">
</a>

The gem is available as open source under the terms of the [MIT License](https://opensource.org/licenses/MIT).

<br>

<a href="#table-of-contents">
<img src="https://raw.githubusercontent.com/a6b8/a6b8/main/docs/write-invoice-for-ruby/readme/headlines/code-of-conduct.svg" height="38px" name="code-of-conduct" alt="Code of Conduct">
</a>
    
Everyone interacting in the write-invoice-for-ruby project's codebases, issue trackers, chat rooms and mailing lists is expected to follow the [code of conduct](https://github.com/a6b8/write-invoice-for-ruby/blob/master/CODE_OF_CONDUCT.md).

<br>

<a href="#table-of-contents">
<img href="#table-of-contents" src="https://raw.githubusercontent.com/a6b8/a6b8/main/docs/write-invoice-for-ruby/readme/headlines/support-my-work.svg" height="38px" name="support-my-work" alt="Support my Work">
</a>
    
Donate by [https://www.paypal.com](https://www.paypal.com/donate?hosted_button_id=XKYLQ9FBGC4RG)