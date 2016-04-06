module Helpers

	def send_bookings(bookings)
    bookings.map { |booking| get_date_range(booking) }.flatten
  end

  def get_date_range(booking)
    (booking.start_date...booking.end_date).map { |date| date.to_s }
  end

  def current_user
    @current_user ||= User.get(session[:user_id])
  end

  def get_space_name(space_id)
    Space.first(id: space_id).name
  end

  def get_user_name(user_id)
    User.first(id: user_id).username
  end

  def space_ids_to_array
    spaces = Space.all(user_id: session[:user_id])
    space_ids = []
    spaces.each do |space|
      space_ids.push(space.id)
    end
    space_ids
  end

end