Gem::Specification.new do |s|
  s.platform    = Gem::Platform::RUBY
  s.name        = 'spree_notes'
  s.version     = '0.0.1'
  s.summary     = 'Allows admins to add custom notes to orders and users'
  s.description = 'Allows admins to add custom notes to orders and users'
  s.required_ruby_version = '>= 1.9.3'

  s.author            = 'Chris Ewa;d'
  s.email             = 'chris@railsdog.com'
  # s.homepage          = 'http://github.com'
  # s.rubyforge_project = 'spree_notes'

  s.files        = Dir['README.md', 'lib/**/*', 'app/**/*', 'config/*']
  s.require_path = 'lib'
  s.requirements << 'none'

  # s.has_rdoc = true

  s.add_development_dependency 'factory_girl', '4.4'
  s.add_development_dependency 'ffaker'
  s.add_development_dependency 'rspec-rails', '2.14'
  s.add_development_dependency 'sqlite3', '~> 1.3.8'
  s.add_development_dependency 'capybara', '~> 2.2.1'
  s.add_development_dependency 'poltergeist', '~> 1.5.0'
  s.add_development_dependency 'database_cleaner', '~> 1.2.0'
  s.add_development_dependency 'sass-rails', '~> 4.0.0'
  s.add_development_dependency 'pry-rails'
end
