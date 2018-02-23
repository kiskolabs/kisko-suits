require "#{File.dirname(__FILE__)}/lib/kisko-suits/version"

Gem::Specification.new do |s|
  s.name = "kisko-suits"
  s.version = KiskoSuits::VERSION
  s.platform = Gem::Platform::RUBY
  s.authors = ["Antti Akonniemi"]
  s.license = "MIT"
  s.email = ["antti@kiskolabs.com"]
  s.homepage = "http://github.com/kiskolabs/kisko-suits"
  s.summary = "Application to compile files as one"
  s.description = "This app was meant to compile markdown partials as one document for our sales team using Deckset for Mac"
  s.files = Dir.glob("{bin,lib,test,examples,doc,data}/**/*") + %w(README.md)
  s.require_path = 'lib'
  s.executables = ["kisko-suits"]
  s.required_ruby_version = ">= 1.9.2"
  s.required_rubygems_version = ">= 1.3.6"
  s.rubyforge_project = "kisko-suits"

  s.add_dependency "filewatcher", ">= 1.0.1"
  s.add_development_dependency "rspec", ">= 3.2.0"
end
