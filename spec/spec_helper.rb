require 'pathname'

ROOT = Pathname.new(File.expand_path('../..', __FILE__))
$: << ROOT
require 'exception_manager'
require 'pry'
require 'rspec/its'

Dir[ROOT.join('spec/support/**/*.rb')].each { |f| require f }

RSpec.configure do |config|
  config.expect_with :rspec do |expectations|
    expectations.include_chain_clauses_in_custom_matcher_descriptions = true
  end

  config.mock_with :rspec do |mocks|
    mocks.verify_partial_doubles = true
  end

  config.before(:suite) do
    ExceptionManager.enable!
  end

  config.order = :random
end
