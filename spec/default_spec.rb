describe 'orientdb::default' do
  let(:runner) do
    runner = ChefSpec::SoloRunner.new do |node|
      node.set[described_cookbook]['installation_directory'] = $installation_directory
      node.set[described_cookbook]['user']['id'] = $user_id
      node.set[described_cookbook]['version'] = $version
      node.set[described_cookbook]['flavour'] = $flavour
      node.set[described_cookbook]['base_tarball_url'] = $base_tarball_url
      node.set[described_cookbook]['default_init_script'] = $default_init_script
      node.set[described_cookbook]['init_script'] = $init_script
    end
    runner.converge(described_recipe)
  end

  it 'includes the apt recipe' do
    expect(runner).to include_recipe('apt')
  end

  it 'includes the java recipe' do
    expect(runner).to include_recipe('java')
  end

  it 'includes the orientdb::user recipe' do
    expect(runner).to include_recipe("#{described_cookbook}::user")
  end

  it 'includes the orientdb::structure recipe' do
    expect(runner).to include_recipe("#{described_cookbook}::structure")
  end

  it 'includes the orientdb::resources recipe' do
    expect(runner).to include_recipe("#{described_cookbook}::resources")
  end

  it 'includes the orientdb::configuration recipe' do
    expect(runner).to include_recipe("#{described_cookbook}::configuration")
  end

  it 'includes the orientdb::scripts recipe' do
    expect(runner).to include_recipe("#{described_cookbook}::scripts")
  end

  it 'stop the (old) service' do
    allow(File).to receive(:exist?)
      .and_call_original
    allow(File).to receive(:exist?)
      .with($init_script)
      .and_return(true)
    expect(runner).to stop_service 'orientdb_old'
  end

  it 'don\'t stop the (old) service - no init script.' do
    allow(File).to receive(:exist?)
      .and_call_original
    allow(File).to receive(:exist?)
      .with($init_script)
      .and_return(false)
    expect(runner).to_not stop_service 'orientdb_old'
  end

  it 'disable the (old) service' do
    allow(File).to receive(:exist?)
      .and_call_original
    allow(File).to receive(:exist?)
      .with($init_script)
      .and_return(true)
    expect(runner).to disable_service 'orientdb_old'
  end

  it 'don\'t disable the (old) service - no init script.' do
    allow(File).to receive(:exist?)
      .and_call_original
    allow(File).to receive(:exist?)
      .with($init_script)
      .and_return(false)
    expect(runner).to_not disable_service 'orientdb_old'
  end

  it 'start the (new) service' do
    expect(runner).to start_service 'orientdb_new'
  end

  it 'enable the (new) service' do
    expect(runner).to enable_service 'orientdb_new'
  end
end
