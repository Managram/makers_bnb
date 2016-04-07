class Request

  include DataMapper::Resource

  property :id,          Serial
  property :start_date,  Date
  property :end_date,    Date
  property :status,      Integer
  property :time_stamp,  Time, default: proc { Time.now }

	belongs_to :space
  belongs_to :user

  def time
    self.time_stamp.strftime("%Y-%m-%d")
  end

end
