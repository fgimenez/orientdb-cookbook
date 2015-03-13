require 'chefspec'
require 'chefspec/berkshelf'

ChefSpec::Coverage.start!

$default_init_script = '/dir1/dir2/dir3/default_script'
$init_script = '/dir1/dir2/init_script'
$installation_directory = '/custom_dir1/custom_dir2'
$user_id = 'custom_username'
$base_tarball_url = 'http://www.base-url.com/orientdb'
$version = '0.1.2'
$flavour = 'platinum'

RSpec.configure do |config|
  config.platform = 'ubuntu'

  config.version = '12.04'
end
