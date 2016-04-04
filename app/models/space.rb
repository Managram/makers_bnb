require 'data_mapper'

class Space
  include DataMapper::Resource

  property :id,          Serial
  property :name,        String
  property :description, String
  property :price,       Big, :scale => 2

end
