require 'spec_helper'

describe RCelery::Configuration do
  before :each do
    @config = RCelery::Configuration.new
  end

  it 'defaults the host to localhost' do
    @config.host.should == 'localhost'
  end

  it 'defaults the port to 5672' do
    @config.port.should == 5672
  end

  it 'defaults the vhost to /' do
    @config.vhost.should == '/'
  end

  it 'defaults the username to guest' do
    @config.username.should == 'guest'
  end

  it 'defaults the password to guest' do
    @config.password.should == 'guest'
  end

  it 'defaults the application to application' do
    @config.application.should == 'application'
  end

  it 'defaults the worker count to 1' do
    @config.worker_count.should == 1
  end

  it 'defaults eager mode to false' do
    @config.eager_mode.should == false
  end

  it 'defaults AMQP auto recovery to false' do
    @config.amqp_auto_recovery.should == false
  end

  it 'defaults AMQP reconnect wait time to 10 seconds' do
    @config.amqp_reconnect_wait_time.should == 10
  end

  it 'overrides the default host when a hash is given to initialize' do
    config = RCelery::Configuration.new(:host => 'otherhost')
    config.host.should == 'otherhost'
  end

  it 'overrides the default port when a hash is given to initialize' do
    config = RCelery::Configuration.new(:port => 1234)
    config.port.should == 1234
  end

  it 'overrides the default vhost when a hash is given to initialize' do
    config = RCelery::Configuration.new(:vhost => '/different')
    config.vhost.should == '/different'
  end

  it 'overrides the default username when a hash is given to initialize' do
    config = RCelery::Configuration.new(:username => 'user')
    config.username.should == 'user'
  end

  it 'overrides the default password when a hash is given to initialize' do
    config = RCelery::Configuration.new(:password => 'password')
    config.password.should == 'password'
  end

  it 'overrides the default application when a hash is given to initialize' do
    config = RCelery::Configuration.new(:application => 'otherapp')
    config.application.should == 'otherapp'
  end

  it 'overrides the default amqp_auto_recovery status when a hash is given to initialize' do
    config = RCelery::Configuration.new(:amqp_auto_recovery => true)
    config.amqp_auto_recovery.should == true
  end

  it 'overrides the default amqp_reconnect_wait_time when a hash is given to initialize' do
    config = RCelery::Configuration.new(:amqp_reconnect_wait_time => 30)
    config.amqp_reconnect_wait_time.should == 30
  end

  it 'overrides the eager mode setting' do
    config = RCelery::Configuration.new(:eager_mode => true)
    config.eager_mode.should == true
  end

  it 'has a hash representation' do
    @config.to_hash.should == {
      :host => 'localhost',
      :port => 5672,
      :vhost => '/',
      :username => 'guest',
      :password => 'guest',
      :application => 'application',
      :worker_count => 1,
      :eager_mode => false,
      :amqp_auto_recovery => false,
      :amqp_reconnect_wait_time => 10,
    }
  end

  it 'overrides the default worker count when a hash is given to initialize' do
    config = RCelery::Configuration.new(:worker_count => 23)
    config.worker_count.should == 23
  end

  it 'updates configuration with the supplied hash' do
    @config.application = "this_app"
    @config.update_with_hash({:application => "test_app"})
    @config.application.should == "test_app"
  end

  it 'does not revert old config options' do
    @config.password = "this_pass"
    @config.update_with_hash({:application => "test_app"})
    @config.password.should == "this_pass"
  end

  it 'updates config with the supplied hash with string keys' do
    @config.update_with_hash({'vhost' => '/qa', 'host' => 'test-mq', 'application' => "test_app"})
    @config.application.should == "test_app"
  end
end
