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
    expect(runner).to create_user(default_user_name)#.
      #with(shell: 'bin/false', system: true, 
      #     home: installation_directory)
  end

end
