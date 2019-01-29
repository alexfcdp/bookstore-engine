# frozen_string_literal: true

require 'spec_helper'
ENV['RAILS_ENV'] ||= 'test'
require File.expand_path('../config/environment', __dir__)

abort('The Rails environment is running in production mode!') if Rails.env.production?
require 'rspec/rails'
require 'shoulda/matchers'
require 'support/factory_bot'
require 'support/capybara'
require 'ffaker'
require 'simplecov'

SimpleCov.start

ActiveRecord::Migration.maintain_test_schema!

RSpec.configure do |config|
  config.fixture_path = "#{::Rails.root}/spec/fixtures"
  config.use_transactional_fixtures = true
  config.infer_spec_type_from_file_location!
  config.filter_rails_from_backtrace!
  config.include Devise::Test::ControllerHelpers, type: :controller
  config.include Warden::Test::Helpers, type: :feature
  config.include Rails.application.routes.url_helpers
  config.before(:each, type: :feature) do
    default_url_options[:locale] = I18n.default_locale
  end
  config.before(:each, type: :controller) do
    default_url_options[:locale] = I18n.default_locale
  end

  %i[controller view request].each do |type|
    config.include ::Rails::Controller::Testing::TestProcess, type: type
    config.include ::Rails::Controller::Testing::TemplateAssertions, type: type
    config.include ::Rails::Controller::Testing::Integration, type: type
  end
end

Shoulda::Matchers.configure do |config|
  config.integrate do |with|
    with.test_framework :rspec
    with.library :rails
  end
end
