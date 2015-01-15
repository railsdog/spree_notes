lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'spree_notes/version'

Gem::Specification.new do |s|
  s.platform    = Gem::Platform::RUBY
  s.name        = 'spree_notes'
  s.version     = SpreeNotes::VERSION
  s.summary     = 'Allows admins to add custom notes to orders and users'
  s.description = 'Allows admins to add custom notes to orders and users'
  s.required_ruby_version = '>= 1.9.3'

  s.author            = 'Chris Ewa;d'
  s.email             = 'chris@railsdog.com'
  # s.homepage          = 'http://github.com'
  # s.rubyforge_project = 'spree_notes'

  s.files        = Dir['{app,config,db,lib}/**/*',
                       'Rakefile',
                       'README.md']
  s.test_files   = `git ls-files -- spec/*`.split("\n")
  s.require_path = 'lib'
  s.requirements << 'none'
  s.required_ruby_version = '>= 1.9.3'

  s.add_dependency 'spree_core', '~> 2.4.0'

  s.add_development_dependency 'sass-rails'
  s.add_development_dependency 'coffee-rails'

  s.add_development_dependency 'bundler'
  s.add_development_dependency 'rake', '~> 10.0'
  s.add_development_dependency 'sqlite3', '~> 1.3'
  s.add_development_dependency 'rspec-rails', '~> 2.14'
  s.add_development_dependency 'capybara', '~> 2.2'
  s.add_development_dependency 'database_cleaner', '1.2'
  s.add_development_dependency 'poltergeist', '1.5'
  s.add_development_dependency 'factory_girl', '~> 4.4'
  s.add_development_dependency 'simplecov', '~> 0.7'
  s.add_development_dependency 'shoulda-matchers', '~> 2.5'
end
