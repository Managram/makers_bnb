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
    unavailable_dates = retrieve_bookings(Request.all(space_id: space.id, status: 2))
    date_conflicts(dates, unavailable_dates)
  end

  def date_conflicts(dates, requested_dates)
    date_conflicts = []
    dates.each { |date| date_conflicts << date if requested_dates.include?(date) }
    date_conflicts
  end

  def js_to_rb_date(date)
    Date.parse(date)
  end

  def decline_requests(dates, space)
    requests = Request.all(space_id: space.id, status: 1)      
    requests.each do | request |      
      requested_dates = get_date_range(request.start_date, request.end_date)
      if !date_conflicts(dates, requested_dates).empty?
        request.status = 0
        request.save
      end
    end
  end

end
