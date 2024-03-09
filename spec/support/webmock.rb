# frozen_string_literal: true

require 'webmock/rspec'

WebMock.disable_net_connect!(allow_localhost: true)

RSpec.configure do |config|
  config.before do
    # stub_request(:get, 'https://xxx')
    #   .to_return(status: 200, body: '[]', headers: {})
  end
end
