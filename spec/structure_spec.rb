require_relative 'spec_helper'

describe 'orientdb::structure' do
  let(:base_installation_directory) {'dir'}
  let(:default_user_name) {'username'}
    
  let(:runner) do
    runner = ChefSpec::SoloRunner.new do |node|
      node.set[described_cookbook]['base_installation_directory'] = base_installation_directory
      node.set[described_cookbook]['user']['id'] = default_user_name
    end
    runner.converge(described_recipe)
  end
  
  it 'creates the directory with the right ownership' do
    expect(runner).to create_directory(base_installation_directory).with(
                       user: default_user_name,
                       group: default_user_name
                     )
  end
end
