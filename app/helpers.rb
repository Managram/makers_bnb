module Helpers

	def retrieve_bookings(bookings)
    bookings.map { |booking| get_date_range(booking.start_date, booking.end_date) }.flatten
  end

  def get_date_range(start_date, end_date)
    (start_date...end_date).map { |date| date.to_s }
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

  def date_match(dates, space)
    unavailable_dates = retrieve_bookings(Booking.all(space_id: space.id))
    date_conflicts = []
    dates.each { |date| date_conflicts << date if unavailable_dates.include?(date) }
    date_conflicts
  end

  def js_to_rb_date(date)
    Date.parse(date)
  end

end
