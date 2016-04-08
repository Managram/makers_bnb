class Space

  include DataMapper::Resource

  property :id,          Serial
  property :name,        String, required: true, unique: true
  property :description, String, required: true
  property :price,       Float,  required: true, scale: 2

  belongs_to :user
 	has n, :requests

end
