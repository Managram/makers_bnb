class MakersBnb < Sinatra::Base

	get '/booked-dates/:id' do
		bookings = Request.all(space_id: params[:id], status: 2)
    booked_dates = retrieve_bookings(bookings)
    JSON.generate({ dates: booked_dates })
  end

  post '/booking-requests/accepted/:request_id' do
    request = Request.first(id: params[:request_id])
    request.status = 2
    request.save
    confirmed_dates = get_date_range(request.start_date, 
                                    request.end_date)
    space = Space.first(id: request.space_id)
    decline_requests(confirmed_dates, space)
    redirect "/my-spaces/#{request.space_id}"
  end

end
