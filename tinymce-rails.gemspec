# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'tinymce/rails/version'

Gem::Specification.new do |spec|
  spec.name          = "tinymce-rails"
  spec.version       = TinyMCE::Rails::VERSION
  spec.authors       = ["Bartek Bulat"]
  spec.email         = ["bartek@1000i.pl"]
  spec.description   = %q{Gem for integration TinyMCE 4 and Rails}
  spec.summary       = %q{Gem for integration TinyMCE 4 and Rails with TinyMCE upload plugin}
  spec.homepage      = ""
  spec.license       = "MIT"

  spec.files         = `git ls-files`.split($/).delete_if do |file|
    file.match(/lib\/gem_tasks\/.*rake$/)
  end
  spec.executables   = spec.files.grep(%r{^bin/}) { |f| File.basename(f) }
  spec.test_files    = spec.files.grep(%r{^(test|spec|features)/})
  spec.require_paths = ["lib"]

  spec.add_development_dependency "bundler", "~> 1.3"
  spec.add_development_dependency "rake"
  spec.add_runtime_dependency 'paperclip'
  spec.add_runtime_dependency 'rails-i18n'
  spec.add_runtime_dependency 'jquery-ui-rails'
  spec.add_runtime_dependency 'jquery-fileupload-rails'
end
