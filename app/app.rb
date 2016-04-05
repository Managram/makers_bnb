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

  get '/user/new' do
    erb(:"user/new")
  end

  post '/user/new' do
    user = User.create(name: params[:name])
    session[:user_id] = user.id
    redirect '/space/new'
  end

  helpers do
    def current_user
      @current_user ||= User.get(session[:user_id])
    end
  end

  get '/reservation' do
    File.read(File.join('public', 'calendar.html'))
  end

  post '/reservation' do
    Request.create(start_date: params[:start_date], end_date: params[:end_date], status: 1)
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
