# Spree Notes

Add notes to orders and users. Only available to admins.


## Installation

#### Branch

Add this line to your Spree application's Gemfile:

    gem 'spree_notes', github: 'railsdog/spree_notes', branch: '2-4-stable'

#### Bleeding Edge

Add this line to your Spree application's Gemfile:

    gem 'spree_notes', github: 'railsdog/spree_notes'

> Note: The master branch is not guaranteed to be in a fully functioning state. It is unwise to use this branch in a production system.

#### Generator

Run the bundle command to install it:

    bundle install

After installing, you'll need to run the generator:

    bundle exec rails g spree_notes:install


## Testing

Generate a dummy application

    bundle exec rake test_app

Running tests

    bundle exec rake spec


## Contributing

1. Fork it ( https://github.com/railsdog/spree_notes/fork )
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am 'Add some feature'`)
4. Push to the branch (`git push origin my-new-feature`)
