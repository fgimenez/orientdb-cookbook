require_relative 'spec_helper'

describe 'orientdb::dependencies' do
  let(:runner) { ChefSpec::ChefRunner.new(platform: 'ubuntu', version: '12.04').
    converge('orientdb::dependencies')}

  it 'installs the unzip package' do
    expect(runner).to install_package('unzip')
  end
end
