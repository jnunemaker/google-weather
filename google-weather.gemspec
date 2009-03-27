# -*- encoding: utf-8 -*-

Gem::Specification.new do |s|
  s.name = %q{google-weather}
  s.version = "0.2.0"

  s.required_rubygems_version = Gem::Requirement.new(">= 0") if s.respond_to? :required_rubygems_version=
  s.authors = ["John Nunemaker"]
  s.date = %q{2009-03-27}
  s.default_executable = %q{weather}
  s.email = %q{nunemaker@gmail.com}
  s.executables = ["weather"]
  s.extra_rdoc_files = ["README.rdoc", "LICENSE"]
  s.files = ["README.rdoc", "VERSION.yml", "bin/weather", "lib/google_weather", "lib/google_weather/data.rb", "lib/google_weather.rb", "test/fixtures", "test/fixtures/46544.xml", "test/google_weather_test.rb", "test/test_helper.rb", "LICENSE"]
  s.has_rdoc = true
  s.homepage = %q{http://github.com/jnunemaker/google-weather}
  s.rdoc_options = ["--inline-source", "--charset=UTF-8"]
  s.require_paths = ["lib"]
  s.rubygems_version = %q{1.3.1}
  s.summary = %q{stupid simple fetching of the weather using google's api}

  if s.respond_to? :specification_version then
    current_version = Gem::Specification::CURRENT_SPECIFICATION_VERSION
    s.specification_version = 2

    if Gem::Version.new(Gem::RubyGemsVersion) >= Gem::Version.new('1.2.0') then
    else
    end
  else
  end
end
