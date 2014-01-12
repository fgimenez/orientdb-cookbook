require_relative 'spec_helper'

describe 'orientdb::default' do
  let(:runner) { ChefSpec::Runner.new.converge(described_recipe) }

  it 'includes the apt recipe' do
    expect(runner).to include_recipe('apt')
  end

  it 'includes the java recipe' do
    expect(runner).to include_recipe('java')
  end

  it 'includes the orientdb::user recipe' do
    expect(runner).to include_recipe("#{described_cookbook}::user")
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

end
