require_relative 'spec_helper'

describe 'orientdb::user' do
  let(:installation_directory) {'dir'}
  let(:default_user_name) {'username'}

  let(:runner) do
    runner = ChefSpec::ChefRunner.new(platform: 'ubuntu', version: '12.04') do |node|
      node.set[:orientdb][:user][:id] = default_user_name
      node.set[:orientdb][:installation_directory] = installation_directory
    end
    runner.converge('orientdb::user')
  end

  it 'creates the default user' do
    user = runner.user(default_user_name)
    expect(user.shell).to eq('/bin/false')
    expect(user.home).to eq(installation_directory)
    expect(user.system).to be_true
  end

end
