# Tinymce::Rails

TinyMCE 4 and Rails assets pipeline integration

## Installation

Add this line to your application's Gemfile:

    gem 'tinymce-rails'

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install tinymce-rails

## Usage

TODO: Write usage instructions here

You can override your TinyMCE configuration in config/tinymce.yml, but then you must include

	<%= tinymce_init_styles %>

in your layout template. This helper reloaded necessary configs at server start.

## Contributing

1. Fork it
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am 'Add some feature'`)
4. Push to the branch (`git push origin my-new-feature`)
5. Create new Pull Request
