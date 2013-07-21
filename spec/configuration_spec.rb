require_relative 'spec_helper'

describe 'orientdb::configuration' do
  let(:installation_directory) {'dir'}
  let(:db_user) {'db_user'}
  let(:db_password) {'db_password'}
  let(:version) {'version'}
  let(:config_file) {'config_file'}

  let(:runner) do
    runner = ChefSpec::ChefRunner.new(platform: 'ubuntu', version: '12.04') do |node|
      node.set[:orientdb][:installation_directory] = installation_directory
      node.set[:orientdb][:main_config_file] = config_file
      node.set[:orientdb][:db_user] = db_user
      node.set[:orientdb][:db_password] = db_password
      node.set[:orientdb][:version] = version
    end
    runner.converge('orientdb::configuration')
  end

  describe 'configuration file' do
    it 'should be created' do
      expect(runner).to create_file(config_file)
    end

    describe 'config file features' do
      let(:file) {runner.template(config_file)}
      
      it 'should have the right content for the db user'

      it 'should have the right content for the in memory user'
    end
  end
end
