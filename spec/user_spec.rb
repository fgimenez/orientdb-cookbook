require_relative 'spec_helper'

describe 'orientdb::user' do
  let(:installation_directory) {'dir'}
  let(:default_user_name) {'username'}

  let(:runner) do
    runner = ChefSpec::SoloRunner.new do |node|
      node.set[described_cookbook]['user']['id'] = default_user_name
      node.set[described_cookbook]['installation_directory'] = installation_directory
    end
    runner.converge(described_recipe)
  end

  it 'creates the default group' do
    expect(runner).to create_group(default_user_name)
  end

  it 'creates the default user' do
    user = runner.user(default_user_name)
    expect(user.shell).to eq('/bin/bash')
    expect(user.home).to eq(installation_directory)
    expect(user.gid).to eq(default_user_name)
  end

end
