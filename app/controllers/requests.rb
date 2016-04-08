class MakersBnb < Sinatra::Base

	get '/reservation/:id' do
    @space = Space.first(id: params[:id])
    erb(:'calendar')
  end

  post '/reservation' do
    Request.create(start_date: params[:start_date],
                   end_date: params[:end_date],
                   status: 1,
                   space_id: params[:space_id],
                   user_id: session[:user_id])
  end

  get '/my-bookings' do
    @pending_requests = Request.all(user_id: session[:user_id], status: 1)
		@confirmed_requests = Request.all(user_id: session[:user_id], status: 2)
		@declined_requests = Request.all(user_id: session[:user_id], status: 0)
    erb(:'requests/booking-requests')
  end

  post '/booking-requests/declined/:request_id' do
    request = Request.first(id: params[:request_id])
    request.status = 0
    request.save
    redirect "/my-spaces/#{request.space_id}"
  end

end
