module ResetConfigHelper
  def self.included(base)
    base.instance_eval do
      around(:each) do |example|
        example.run
        ExceptionManager.reset_filters!
        ExceptionManager.enable!
      end
    end
  end
end

RSpec.configure do |config|
  config.include ResetConfigHelper
end
