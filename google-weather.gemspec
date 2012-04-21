# -*- encoding: utf-8 -*-
require File.expand_path("../lib/google_weather/version", __FILE__)

Gem::Specification.new do |s|
  s.name        = "google-weather"
  s.version     = GoogleWeather::VERSION
  s.platform    = Gem::Platform::RUBY
  s.authors     = ["John Nunemaker"]
  s.email       = ["nunemaker@gmail.com"]
  s.homepage    = "http://rubygems.org/gems/google-weather"
  s.summary     = "stupid simple fetching of the weather using google's api"
  s.description = "stupid simple fetching of the weather using google's api"

  s.required_rubygems_version = ">= 1.3.6"
  s.rubyforge_project         = "google-weather"

  s.add_dependency "httparty", "~> 0.5.0"

  s.files        = `git ls-files`.split("\n")
  s.executables  = `git ls-files`.split("\n").map{|f| f =~ /^bin\/(.*)/ ? $1 : nil}.compact
  s.require_path = 'lib'
  s.extra_rdoc_files = ["README.rdoc", "LICENSE"]
  s.has_rdoc = true
  s.homepage = "http://github.com/jnunemaker/google-weather"
  s.rdoc_options = ["--inline-source", "--charset=UTF-8"]
end
