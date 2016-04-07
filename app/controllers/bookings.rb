class MakersBnb < Sinatra::Base

	get '/booked-dates/:id' do
    bookings = Booking.all(space_id: params[:id])
    booked_dates = retrieve_bookings(bookings)
    JSON.generate({ dates: booked_dates })
  end

  post '/booking-requests/accepted/:request_id' do
    request = Request.first(id: params[:request_id])
    Booking.create(start_date: request.start_date,
                   end_date: request.end_date,
                   space_id: request.space_id,
                   user_id: request.space_id)
    request.status = 2
    request.save
    redirect '/booking-requests'
  end

end