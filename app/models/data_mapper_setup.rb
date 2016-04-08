require 'data_mapper'
require 'dm-postgres-adapter'

require_relative 'space'
require_relative 'user'
require_relative 'request'

DataMapper.setup(:default,  ENV['DATABASE_URL'] || "postgres://localhost/makersbnb_#{ENV['RACK_ENV']}")
DataMapper.finalize
DataMapper.auto_upgrade!
