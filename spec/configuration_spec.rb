describe 'orientdb::configuration' do
  let(:runner) do
    runner = ChefSpec::SoloRunner.new do |node|
      node.set['orientdb']['installation_directory'] = $installation_directory
      node.set['orientdb']['user']['id'] = $user_id
    end
    runner.converge(described_recipe)
  end

  describe 'configuration files' do
    it 'creates default-distributed-db-config.json' do
      expect(runner).to create_template("#{$installation_directory}/config/default-distributed-db-config.json").with(
        owner: $user_id,
        group: $user_id
      )
    end
    it 'creates hazelcast.xml' do
      expect(runner).to create_template("#{$installation_directory}/config/hazelcast.xml").with(
        owner: $user_id,
        group: $user_id
      )
    end
    it 'creates orientdb-server-config.xml' do
      expect(runner).to create_template("#{$installation_directory}/config/orientdb-server-config.xml").with(
        owner: $user_id,
        group: $user_id
      )
    end
  end
end
