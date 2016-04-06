ENV['RACK_ENV'] ||= 'development'

require_relative 'models/data_mapper_setup'
require 'sinatra/base'
require 'sinatra/flash'
require 'tilt/erb'
require 'json'
require_relative 'server'
require_relative 'controllers/spaces'
require_relative 'controllers/users'
require_relative 'controllers/sessions'
require_relative 'controllers/requests'
require_relative 'controllers/bookings'

# start the server if ruby file executed directly


