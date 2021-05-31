# frozen_string_literal: true

require 'simplecov'
require 'shoulda/matchers'

SimpleCov.start 'rails' do
  add_filter '/app/models/application_record.rb'
  add_filter '/app/mailers/application_mailer.rb'
  add_filter '/app/jobs/application_job.rb'
  add_filter '/app/channels'
  add_filter '/bin'
  add_filter '/coverage'
  add_filter '/db'
  add_filter '/log'
  add_filter '/tmp'
end

SimpleCov.minimum_coverage 92.5

RSpec.configure do |config|
  config.expect_with :rspec do |expectations|
    expectations.include_chain_clauses_in_custom_matcher_descriptions = true
  end

  config.mock_with :rspec do |mocks|
    mocks.verify_partial_doubles = true
  end

  RSpec.configure do |config|
    config.before(type: :request) do
      host! 'localhost:3000'
    end
  end

  config.shared_context_metadata_behavior = :apply_to_host_groups
end
