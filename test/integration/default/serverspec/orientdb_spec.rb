require 'serverspec'

set :backend, :exec

describe 'Orientdb service' do

  %w(2424 2480).each do |port|
    it "is listening on port #{port}" do
      expect(port(port)).to be_listening
    end
  end

end
