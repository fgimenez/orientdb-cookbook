require_relative '../spec_helper'

shared_examples "config file creator" do |target_file, content, mode|
  let(:config_file) { runner.cookbook_file(target_file) }

  it "creates the configuration file with the right content" do
    expect(runner).to create_file_with_content(target_file,
                                               content)
  end

  it "creates the configuration file with the right owner" do
    expect(config_file).to be_owned_by('root', 'root')
  end

  it "creates the configuration file with the right flags" do
    expect(config_file.mode).to eq(mode)
  end
end

shared_examples "config template creator" do |target_file, content, mode|
  let(:config_file) { runner.template(target_file) }
  it "creates the configuration file with the right content" do
    expect(runner).to create_file_with_content(target_file,
                                               content)
  end

  it "creates the configuration file with the right owner" do
    expect(config_file).to be_owned_by('root', 'root')
  end

  it "creates the configuration file with the right flags" do
    expect(config_file.mode).to eq(mode)
  end
end
