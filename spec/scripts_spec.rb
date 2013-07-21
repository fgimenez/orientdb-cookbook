require_relative 'spec_helper'

describe 'orientdb::scripts' do
  let(:installation_directory) {'dir'}
  let(:user) {'user'}

  let(:runner) do
    runner = ChefSpec::ChefRunner.new(platform: 'ubuntu', version: '12.04') do |node|
      node.set[:orientdb][:installation_directory] = installation_directory
      node.set[:orientdb][:user][:id] = user
    end
    runner.converge('orientdb::scripts')
  end

  
end
