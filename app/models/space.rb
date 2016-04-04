require 'data_mapper'

class Space
  include DataMapper::Resource

  property :id, Serial
  property :title, String
end
