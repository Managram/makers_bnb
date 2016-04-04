require_relative 'space'
require_relative 'request'

DataMapper.setup(:default,  ENV['DATABASE_URL'] || "postgres://localhost/makersbnb_#{ENV['RACK_ENV']}")
DataMapper.finalize
