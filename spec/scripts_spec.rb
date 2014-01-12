require_relative 'spec_helper'

describe 'orientdb::scripts' do
  let(:default_init_script) {'/opt/orientdb/bin/orientdb'}
  let(:init_script) {'/etc/init.d/orientdb'}
  let(:user) {'user'}
  let(:installation_directory) {'installation_directory'}

  let(:runner) do
    runner = ChefSpec::Runner.new do |node|
      node.set[described_cookbook]['user']['id'] = user
      node.set[described_cookbook]['installation_directory'] = installation_directory
      node.set[described_cookbook]['default_init_script'] = default_init_script
      node.set[described_cookbook]['init_script'] = init_script
    end
    runner.converge(described_recipe)
  end

  describe 'init script creation' do
    it 'should copy the init script' do
      expect(runner).to run_execute("cp #{default_init_script} #{init_script}")
    end

    it 'should have the right content for the db path' do
      expect(runner).
        to run_execute("sed -i 's#DB_DIR=\".*\"#DB_DIR=\"#{installation_directory}\"#' #{init_script}")
    end
    
    it 'should have the right content for the db user' do
      expect(runner).
        to run_execute("sed -i 's/DB_USER=\".*\"/DB_USER=\"#{user}\"/' #{init_script}")
    end

    it 'should have the right permissions' do
      file = runner.file(init_script)
      expect(file.mode).to eql('0755')
    end
  end

  describe 'service setup' do
    it 'starts the service' do
      expect(runner).to start_service 'orientdb'
    end

    it 'sets the service to start on boot' do
      expect(runner).to enable_service 'orientdb'
    end
  end
end
