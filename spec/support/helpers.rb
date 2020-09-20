require 'support/session_helpers'

RSpec.configure do |config|
  config.include SessionHelpers, type: :system
end
