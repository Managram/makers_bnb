ENV['RACK_ENV'] ||= 'development'

require_relative 'models/data_mapper_setup'
require 'sinatra/base'
require 'tilt/erb'
require 'json'

class MakersBnb < Sinatra::Base
  enable :sessions

  set :public_folder, 'public'

  get '/space/new' do
    erb(:"space/new")
  end

  helpers do
    def send_bookings(bookings)
      bookings.map { |booking| get_date_range(booking) }.flatten
    end

    def get_date_range(booking)
      (booking.start_date...booking.end_date).map { |date| date.to_s }
    end

    def current_user
      @current_user ||= User.get(session[:user_id])
    end

  end

  post '/space/new' do
    user = User.get(session[:user_id])
    user.spaces.create(name: params[:name],
                       description: params[:description],
                       price: params[:price])
    redirect "/space/index"
  end

  get '/space/index' do
    @spaces = Space.all
    erb(:"space/index")
  end

  get '/space/:id/view' do
    @space = Space.first(id: params[:id])
    erb(:"/space/view")
  end


  get '/booked-dates' do
    booked_dates = send_bookings(Booking.all)
    JSON.generate({ dates: booked_dates })
  end
  
  get '/user/new' do
    erb(:"user/new")
  end

  post '/user/new' do
    user = User.create(name: params[:name])
    session[:user_id] = user.id
    redirect '/space/new'
  end

  get '/reservation/:id' do
    @space = Space.first(id: params[:id])
    # File.read(File.join('public', 'calendar.html.erb'))
    erb(:'calendar')
  end

  post '/reservation' do
    p params[:space_id]
    p session[:user_id]
    Request.create(start_date: params[:start_date], end_date: params[:end_date], status: 1, space_id: params[:space_id], user_id: session[:user_id])
  end

  get '/booking-requests' do
    @requests = Request.all(status: 1)
    erb(:'requests/booking-requests')
  end

  post '/booking-requests/accepted/:request_id' do
    request = Request.first(id: params[:request_id])
    Booking.create(start_date: request.start_date,
                   end_date: request.end_date)
    request.status = 2
    request.save
    redirect '/booking-requests'
  end

  post '/booking-requests/declined/:request_id' do
    request = Request.first(id: params[:request_id])
    request.status = 0
    request.save
    redirect '/booking-requests'
  end

  # start the server if ruby file executed directly
  run! if app_file == $0
end
