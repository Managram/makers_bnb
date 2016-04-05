require_relative 'space'
require_relative 'user'

DataMapper.setup(:default,  ENV['DATABASE_URL'] || "postgres://localhost/makersbnb_#{ENV['RACK_ENV']}")
DataMapper.finalize
