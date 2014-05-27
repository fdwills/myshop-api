$LOAD_PATH << File.join(File.dirname(__FILE__), 'lib')
$LOAD_PATH << File.join(File.dirname(__FILE__), 'app/models')
$LOAD_PATH << File.join(File.dirname(__FILE__), 'app/libs')
$LOAD_PATH << File.join(File.dirname(__FILE__), 'app/controllers')

require 'bundler'
require 'active_record'

ActiveRecord::Base.configurations = YAML.load_file('config/database.yml')

rack_env = ENV['RACK_ENV'] || 'development'
Bundler.require :default, rack_env.to_sym
ActiveRecord::Base.establish_connection(rack_env)

require 'application_controller'
require 'goods_controller'
require 'users_controller'
require 'orders_controller'
require 'all_model'

run Rack::URLMap.new(
  "/goods" => GoodsController,
  "/users" => UsersController,
  "/orders" => OrdersController
)
