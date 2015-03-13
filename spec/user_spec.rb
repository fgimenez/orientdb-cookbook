describe 'orientdb::user' do
  let(:runner) do
    runner = ChefSpec::SoloRunner.new do |node|
      node.set[described_cookbook]['user']['id'] = $user_id
      node.set[described_cookbook]['installation_directory'] = $installation_directory
    end
    runner.converge(described_recipe)
  end

  it 'creates the group' do
    expect(runner).to create_group($user_id)
  end

  it 'creates the user' do
    expect(runner).to create_user($user_id).with(
      shell: '/bin/bash',
      home:  $installation_directory,
      gid:   $user_id)
  end
end
