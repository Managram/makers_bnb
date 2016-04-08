class Space

  include DataMapper::Resource

  property :id,          Serial
  property :name,        String, required: true
  property :description, String, required: true
  property :price,       Float, scale: 2, required: true

  belongs_to :user
 	has n, :requests

end
