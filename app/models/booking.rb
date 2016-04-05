require 'data_mapper'
require 'dm-postgres-adapter'

class Booking

	include DataMapper::Resource

	property :id, 				Serial
  property :start_date, Date
  property :end_date, 	Date

end

DataMapper.setup(:default, "postgres://localhost/makersbnb_#{ENV['RACK_ENV']}")
DataMapper.finalize
DataMapper.auto_upgrade!
