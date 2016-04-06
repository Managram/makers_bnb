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

  get '/booking-requests' do
    @my_requests = Request.all(user_id: session[:user_id], status: 1)
    @received_requests = Request.all(space_id: space_ids_to_array, status: 1)
    erb(:'requests/booking-requests')
  end

  post '/booking-requests/declined/:request_id' do
    request = Request.first(id: params[:request_id])
    request.status = 0
    request.save
    redirect '/booking-requests'
  end

end