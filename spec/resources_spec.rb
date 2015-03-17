describe 'orientdb::resources' do
  let(:destination_file_name) {"#{$flavour}-#{$version}.tar.gz"}
  let(:tarball_url) {"#{$base_tarball_url}-#{destination_file_name}"}
  
  let(:runner) do
    runner = ChefSpec::SoloRunner.new(log_level: :debug) do |node|
      node.set[described_cookbook]['installation_directory'] = $installation_directory
      node.set[described_cookbook]['version'] = $version
      node.set[described_cookbook]['flavour'] = $flavour
      node.set[described_cookbook]['base_tarball_url'] = $base_tarball_url
    end
    runner.converge(described_recipe)
  end

  describe 'main package' do
    it 'removes previous libraries' do
      expect(runner).to delete_directory("#{$installation_directory}/lib")
    end

    it 'removes previous plugins' do
      expect(runner).to delete_directory("#{$installation_directory}/plugins")
    end

    it 'removes previous databases/temp' do
      expect(runner).to delete_directory("#{$installation_directory}/databases/temp")
    end

    it 'tar download' do
      expect(runner).to extract_tar_extract(tarball_url)
    end
  end
end
