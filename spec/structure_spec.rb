describe 'orientdb::structure' do
  let(:runner) do
    runner = ChefSpec::SoloRunner.new do |node|
      node.set[described_cookbook]['installation_directory'] = $installation_directory
      node.set[described_cookbook]['user']['id'] = $user_id
    end
    runner.converge(described_recipe)
  end
  
  it 'creates the directory with the right ownership' do
    expect(runner).to create_directory($installation_directory).with(
                       user: $user_id,
                       group: $user_id
                     )
  end
end
