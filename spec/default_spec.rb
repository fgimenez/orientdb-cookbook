require_relative 'spec_helper'

describe 'orientdb::default' do
  let(:runner) { ChefSpec::ChefRunner.new(platform: 'ubuntu', version: '12.04').
    converge('orientdb::default')}

  it 'includes the apt recipe' do
    expect(runner).to include_recipe('apt')
  end

  it 'includes the java recipe' do
    expect(runner).to include_recipe('java')
  end

  it 'includes the orientdb::user recipe' do
    expect(runner).to include_recipe('orientdb::user')
  end

=begin
  it 'includes the orientdb::structure recipe' do
    expect(runner).to include_recipe('orientdb::structure')
  end
=end

  it 'includes the orientdb::dependencies recipe' do
    expect(runner).to include_recipe('orientdb::dependencies')
  end

  it 'includes the orientdb::resources recipe' do
    expect(runner).to include_recipe('orientdb::resources')
  end

  it 'includes the orientdb::configuration recipe' do
    expect(runner).to include_recipe('orientdb::configuration')
  end

  it 'includes the orientdb::scripts recipe' do
    expect(runner).to include_recipe('orientdb::scripts')
  end

end
