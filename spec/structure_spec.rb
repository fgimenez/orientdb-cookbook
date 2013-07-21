require_relative 'spec_helper'

describe 'orientdb::structure' do
  let(:base_installation_directory) {'dir'}
  let(:default_user_name) {'username'}
    
  let(:runner) do
    runner = ChefSpec::ChefRunner.new(platform: 'ubuntu', version: '12.04') do |node|
      node.set[:orientdb][:base_installation_directory] = base_installation_directory
      node.set[:orientdb][:user][:id] = default_user_name
    end
    runner.converge('orientdb::structure')
  end
  
  describe 'installation directory' do
    it 'creates the directory' do
      expect(runner).to create_directory base_installation_directory      
    end

    it 'with the right ownership' do
      directory = runner.directory(base_installation_directory)
      expect(directory).to be_owned_by(default_user_name, default_user_name)
    end
  end
end
