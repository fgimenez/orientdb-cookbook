require_relative 'spec_helper'

describe 'orientdb::scripts' do
  let(:init_script) {'/etc/init.d/orientdb'}
  let(:user) {'user'}
  let(:installation_directory) {'installation_directory'}
  let(:version) {'1.4.1'}

  let(:runner) do
    runner = ChefSpec::ChefRunner.new(platform: 'ubuntu', version: '12.04') do |node|
      node.set[:orientdb][:user][:id] = user
      node.set[:orientdb][:installation_directory] = installation_directory
      node.set[:orientdb][:version] = version
    end
    runner.converge('orientdb::scripts')
  end

  describe 'init script creation' do
    it 'should have the right content for the db path' do
      expect(runner).
        to create_file_with_content(init_script, 
                                    "DB_DIR=\"#{installation_directory}\"")
    end
    
    it 'should have the right content for the db user' do
      expect(runner).
        to create_file_with_content(init_script, 
                                    "DB_USER=\"#{user}\"")
    end

    it 'should have the right permissions' do
      file = runner.template(init_script)
      expect(file.mode).to eql('0755')
    end
  end

  describe 'service setup' do
    it 'starts the service' do
      expect(runner).to start_service 'orientdb'
    end

    it 'sets the service to start on boot' do
      expect(runner).to set_service_to_start_on_boot 'orientdb'
    end
  end
end
