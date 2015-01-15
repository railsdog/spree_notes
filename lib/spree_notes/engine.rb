module SpreeNotes
  class Engine < ::Rails::Engine
    require 'spree/core'
    isolate_namespace Spree
    engine_name 'spree_notes'

    config.autoload_paths += Dir["#{config.root}/lib"]
    config.generators { |gen| gen.test_framework :rspec }

    def self.activate
      Dir.glob("#{config.root}/app/**/*_decorator*.rb") do |c|
        Rails.application.config.cache_classes ? require(c) : load(c)
      end
    end

    config.to_prepare(&method(:activate).to_proc)
  end
end
