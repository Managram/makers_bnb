ENV['RACK_ENV'] ||= 'development'

require_relative 'models/data_mapper_setup'
require 'sinatra/base'
require 'sinatra/flash'
require 'tilt/erb'
require 'json'

class MakersBnb < Sinatra::Base
  enable :sessions
  set :session_secret, "super_secret"
  set :public_folder, 'public'

  use Rack::MethodOverride

  register Sinatra::Flash

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

  get '/home' do
    erb :index
  end

  get '/space/new' do
    erb(:"space/new")
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
    @user = User.new
    erb(:"user/new")
  end

  post '/user/new' do
    @user = User.new(name: params[:name],
                     email: params[:email],
                     username: params[:username],
                     password: params[:password],
                     password_confirmation: params[:password_confirmation])
    if @user.save
      session[:user_id] = @user.id
      redirect '/space/index'
    else
      flash.now[:errors] = @user.errors.full_messages
      erb(:"user/new")
    end
  end

  get '/sessions/new' do
    erb(:'sessions/new')
  end

  post '/sessions' do
    user = User.authenticate(params[:email],
                             params[:password])
    if user
      session[:user_id] = user.id
      redirect "/space/index"
    else
      flash.now[:errors] = ["Incorrect email or password"]
      erb(:"sessions/new")
    end
  end

  delete '/sessions' do
    session[:user_id] = nil
    redirect '/home'
  end

  get '/reservation/:id' do
    @space = Space.first(id: params[:id])
    erb(:'calendar')
  end

  post '/reservation' do
    p params[:space_id]
    p session[:user_id]
    Request.create(start_date: params[:start_date], end_date: params[:end_date], status: 1, space_id: params[:space_id], user_id: session[:user_id])
  end

  get '/booking-requests' do
    @my_requests = Request.all(user_id: session[:user_id], status: 1)
    @received_requests = Request.all(space_id: space_ids_to_array, status: 1)
    erb(:'requests/booking-requests')
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

  post '/booking-requests/declined/:request_id' do
    request = Request.first(id: params[:request_id])
    request.status = 0
    request.save
    redirect '/booking-requests'
  end

  # start the server if ruby file executed directly
  run! if app_file == $0
end
