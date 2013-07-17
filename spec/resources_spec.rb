require_relative 'spec_helper'

describe 'orientdb::resources' do
  let(:installation_directory) {'dir'}
  let(:base_tarball_url) {'http://www.base-url.com/orientdb'}
  let(:version) {'version'}
  let(:flavour) {'flavour'}
  let(:destination_file_name) {"#{flavour}-#{version}.zip"}
  let(:tarball_url) {"#{base_tarball_url}-#{destination_file_name}"}
  let(:destination_path) {"#{installation_directory}/#{destination_file_name}"}
  let(:user) {'user'}

  let(:runner) do
    runner = ChefSpec::ChefRunner.new(platform: 'ubuntu', version: '12.04') do |node|
      node.set[:orientdb][:installation_directory] = installation_directory
      node.set[:orientdb][:version] = version
      node.set[:orientdb][:flavour] = flavour
      node.set[:orientdb][:base_tarball_url] = base_tarball_url
      node.set[:orientdb][:user][:id] = user
    end
    runner.converge('orientdb::resources')
  end

  describe 'main package' do
    it 'downloads it' do
      expect(runner).to create_remote_file(destination_path).
        with(source: tarball_url)
    end

    it 'extracts it' do
      expect(runner).to execute_command("unzip #{destination_file_name}").
        with(cwd: installation_directory, user: user)
    end

    it 'removes the tarball' do
      expect(runner).to delete_file destination_path
    end
  end
end
