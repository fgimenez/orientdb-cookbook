describe 'orientdb::configuration' do
  let(:runner) do
    runner = ChefSpec::SoloRunner.new do |node|
      node.set['orientdb']['installation_directory'] = $installation_directory
      node.set['orientdb']['user']['id'] = $user_id
    end
    runner.converge(described_recipe)
  end

  describe 'configuration files' do
    ['default-distributed-db-config.json',
     'hazelcast.xml',
     'orientdb-server-config.xml'].each do |config_file|
      it "creates #{config_file}" do
        expect(runner).to create_template(
                            "#{$installation_directory}/config/#{config_file}").with(
                            owner: $user_id,
                            group: $user_id
      )
      end
    end
  end

  describe 'template contents' do
    context 'hazelcast' do
      let(:chef_run) { ChefSpec::SoloRunner.new }
      let(:file) { File.join($installation_directory, 'config', 'hazelcast.xml') }
      context 'multicast enabled' do
        before do
          chef_run.node.set['orientdb']['installation_directory'] = $installation_directory
          chef_run.node.set['orientdb']['hazelcast']['network']['join']['mode'] ='multicast'
          chef_run.node.set['orientdb']['hazelcast']['network']['join']['multicast']['group'] ='my_multicast_group'
          chef_run.node.set['orientdb']['hazelcast']['network']['join']['multicast']['port'] ='my_multicast_port'
          chef_run.converge(described_recipe)
        end

        it 'shows multicast enabled' do
          expect(chef_run).to render_file(file).with_content(/^\s*<multicast enabled="true">$/)
        end

        ['group', 'port'].each do |attr|
          it "shows multicast #{attr}" do
            expect(chef_run).to render_file(file).with_content(
                                  /^\s*<multicast-#{attr}>my_multicast_#{attr}<\/multicast-#{attr}>$/)
          end
        end

        ['tcp-ip', 'aws'].each do |mode|
          it "does not show #{mode} config" do
            expect(chef_run).not_to render_file(file).with_content(/^\s*<#{mode} .*>/)
          end
        end
      end

      context 'tcp-ip enabled' do
        before do
          chef_run.node.set['orientdb']['installation_directory'] = $installation_directory
          chef_run.node.set['orientdb']['hazelcast']['network']['join']['mode'] ='tcp-ip'
          chef_run.node.set['orientdb']['hazelcast']['network']['join']['tcp-ip']['members'] = ['member1', 'member2']
          chef_run.converge(described_recipe)
        end

        it 'shows multicast disabled' do
          expect(chef_run).to render_file(file).with_content(/^\s*<multicast enabled="false">$/)
        end

        it 'shows tcp-ip enabled' do
          expect(chef_run).to render_file(file).with_content(/^\s*<tcp-ip enabled="true">$/)
        end

        it 'shows the members' do
          expect(chef_run).to render_file(file).with_content(/^\s*<member>member1<\/member><member>member2<\/member>$/)
        end
      end

      context 'amazon ec2 enabled' do
        before do
          chef_run.node.set['orientdb']['installation_directory'] = $installation_directory
          chef_run.node.set['orientdb']['hazelcast']['network']['join']['mode'] ='aws'
          ['access-key', 'secret-key', 'region', 'host-header', 'security-group-name',
         'tag-key', 'tag-value'].each do |attr|
            chef_run.node.set['orientdb']['hazelcast']['network']['join']['aws'][attr] = "my_aws_#{attr}"
          end
          chef_run.converge(described_recipe)
        end

        it 'shows multicast disabled' do
          expect(chef_run).to render_file(file).with_content(/^\s*<multicast enabled="false">$/)
        end

        it 'shows aws enabled' do
          expect(chef_run).to render_file(file).with_content(/^\s*<aws enabled="true">$/)
        end

        ['access-key', 'secret-key', 'region', 'host-header', 'security-group-name',
         'tag-key', 'tag-value'].each do |attr|
          it "shows #{attr}" do
            expect(chef_run).to render_file(file).with_content(/^\s*<#{attr}>my_aws_#{attr}<\/#{attr}>$/)
          end
        end
      end
    end
  end
end
