require 'chefspec'
require 'chefspec/berkshelf'
require 'chef/application'

Dir[File.join(File.dirname(__FILE__), "support/**/*.rb")].sort.each {|f| require f}

RSpec.configure do |config|
  config.platform = 'ubuntu'

  config.version = '12.04'
end

at_exit { ChefSpec::Coverage.report! }

#ChefSpec::Coverage.filters << File.expand_path('../../', __FILE__)
