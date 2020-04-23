require 'spec_helper'
ENV['RAILS_ENV'] ||= 'test'

require File.expand_path('../config/environment', __dir__)

abort("The Rails environment is running in production mode!") if Rails.env.production?

require 'rspec/rails'

begin
  ActiveRecord::Migration.maintain_test_schema!
rescue ActiveRecord::PendingMigrationError => e
  puts e.to_s.strip
  exit 1
end

require 'rspec/retry'

RSpec.configure do |config|
  config.fixture_path = "#{::Rails.root}/spec/fixtures"

  config.use_transactional_fixtures = true

  config.infer_spec_type_from_file_location!

  config.filter_rails_from_backtrace!

  config.verbose_retry = true

  config.display_try_failure_messages = true

  config.around :each, :js do |ex|
    ex.run_with_retry retry: 3
  end

  config.retry_callback = proc do |ex|
    if ex.metadata[:js]
      Capybara.reset!
    end
  end
end
