require_relative 'spec_helper'

describe 'orientdb::configuration' do
  let(:db_user) {'db_user'}
  let(:db_password) {'db_password'}
  let(:version) {'1.4.1'}
  let(:config_file) {'config_file'}
  let(:binary_port) {'binary_port'}
  let(:http_port) {'http_port'}

  let(:runner) do
    runner = ChefSpec::ChefRunner.new(platform: 'ubuntu', version: '12.04') do |node|
      node.set[:orientdb][:main_config_file] = config_file
      node.set[:orientdb][:db_user] = db_user
      node.set[:orientdb][:db_password] = db_password
      node.set[:orientdb][:version] = version
      node.set[:orientdb][:binary_port] = binary_port
      node.set[:orientdb][:http_port] = http_port
    end
    runner.converge('orientdb::configuration')
  end

  describe 'configuration file' do
    it 'should be created' do
      expect(runner).to create_file(config_file)
    end

    describe 'config file features' do
      it 'should have the right content for the db user' do
        expect(runner).
          to create_file_with_content(config_file, 
                                      "<storage path=\"memory:temp\" name=\"temp\" userName=\"#{db_user}\" userPassword=\"#{db_password}\" loaded-at-startup=\"true\" />")
      end

      it 'should have the right content for the in memory user' do
      expect(runner).
        to create_file_with_content(config_file, 
                                    "<user name=\"#{db_user}\" password=\"#{db_password}\" resources=\"*\"/>")
      end

      it 'should have the right binary port' do
        expect(runner).
          to create_file_with_content(config_file, 
                                      "<listener protocol=\"binary\" ip-address=\"0.0.0.0\" port-range=\"#{binary_port}-2430\" />")
      end

      it 'should have the right http port' do
        expect(runner).
          to create_file_with_content(config_file, 
                                      "<listener protocol=\"http\" ip-address=\"0.0.0.0\" port-range=\"#{http_port}-2490\">")
      end
    end
  end
end
