require 'data_mapper'
require 'dm-postgres-adapter'
require_relative 'space'
require_relative 'request'
require_relative 'booking'

DataMapper.setup(:default,  ENV['DATABASE_URL'] || "postgres://localhost/makersbnb_#{ENV['RACK_ENV']}")
DataMapper.finalize
DataMapper.auto_upgrade!
