require_relative 'spec_helper'

describe 'orientdb::resources' do
  let(:base_installation_directory) {'dir'}
  let(:installation_directory) {'dir/orientdb'}
  let(:base_tarball_url) {'http://www.base-url.com/orientdb'}
  let(:version) {'version'}
  let(:flavour) {'flavour'}
  let(:destination_file_name) {"#{flavour}-#{version}.zip"}
  let(:tarball_url) {"#{base_tarball_url}-#{destination_file_name}"}
  let(:destination_path) {"#{base_installation_directory}/#{destination_file_name}"}
  let(:user) {'user'}
  
  let(:runner) do
    runner = ChefSpec::ChefRunner.new(platform: 'ubuntu', version: '12.04') do |node|
      node.set[:orientdb][:base_installation_directory] = base_installation_directory
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

    it 'removes previous installations' do
      expect(runner).to delete_directory("#{base_installation_directory}/orientdb-#{flavour}-#{version}")
    end

    it 'extracts it' do
      expect(runner).to execute_command("unzip #{destination_file_name}").
        with(cwd: base_installation_directory, user: nil)
    end

    it 'symlinks it' do
      expect(runner).to execute_command("ln -s orientdb-#{flavour}-#{version} orientdb").
        with(cwd: base_installation_directory, user: nil)
    end

    it 'makes the bin directory executable' do
      expect(runner).to execute_command("chmod -R 0775 bin").
        with(cwd: installation_directory)
    end

    it 'changes its ownership' do
      expect(runner).to execute_command("chown -R #{user}:#{user} .").
        with(cwd: installation_directory, user: nil)
    end

    it 'removes the tarball' do
      expect(runner).to delete_file destination_path
    end
  end
end
