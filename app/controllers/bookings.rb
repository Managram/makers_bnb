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
    redirect "/my-spaces/#{request.space_id}"
  end

end
