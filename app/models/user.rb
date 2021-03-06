require 'data_mapper'
require 'bcrypt'

class User

  include DataMapper::Resource

  property :id,                 Serial
  property :name,               String, required: true
  property :username,           String, required: true, unique: true
  property :password_digest,    Text
  property :email,              String, format: :email_address, required: true, unique: true

  attr_reader :password
  attr_accessor :password_confirmation

  validates_confirmation_of :password

  has n, :spaces
  has n, :requests

  def password=(password)
    @password = password
    self.password_digest = BCrypt::Password.create(password)
  end

  def self.authenticate(email, password)
    user = first(email: email)
    return user if user && BCrypt::Password.new(user.password_digest) == password
    nil
  end
end
