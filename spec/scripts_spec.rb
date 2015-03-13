describe 'orientdb::scripts' do
  let(:runner) do
    runner = ChefSpec::SoloRunner.new do |node|
      node.set[described_cookbook]['user']['id'] = $user_id
      node.set[described_cookbook]['installation_directory'] = $installation_directory
      node.set[described_cookbook]['default_init_script'] = $default_init_script
      node.set[described_cookbook]['init_script'] = $init_script
    end
    runner.converge(described_recipe)
  end

  describe 'init script creation' do
    it 'should copy the init script' do
      expect(runner).to run_execute("cp #{$default_init_script} #{$init_script}")
    end

    it 'should have the right permissions' do
       expect(runner).to create_file($init_script).with(mode: '0755')
    end

    it 'should have the right content for the db path' do
      expect(runner).
        to run_execute("sed -i 's#DB_DIR=\".*\"#DB_DIR=\"#{$installation_directory}\"#' #{$init_script}")
    end
    
    it 'should have the right content for the db user' do
      expect(runner).
        to run_execute("sed -i 's/DB_USER=\".*\"/DB_USER=\"#{$user_id}\"/' #{$init_script}")
    end

    it 'should have the right content for the service stop' do
      expect(runner).
        to run_execute("sed -i 's|./shutdown.sh 1>>../log/orientdb.log 2>>../log/orientdb.err &|./shutdown.sh 1>>../log/orientdb.log 2>>../log/orientdb.err|' #{$init_script}")
    end

    it 'should have the right content for the service status - running' do
      expect(runner).
        to run_execute("sed -i 's|server daemon is running with PID: $PID\"|& \\&\\& exit 0|' #{$init_script}")
    end

    it 'should have the right content for the service status - NOT running' do
      expect(runner).
        to run_execute("sed -i 's|server daemon is NOT running\"|& \\&\\& exit 3|' #{$init_script}")
    end
  end

end
