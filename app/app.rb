ENV['RACK_ENV'] ||= 'development'

require_relative 'models/data_mapper_setup'
require 'sinatra/base'
require 'json'

class MakersBnb < Sinatra::Base

  set :public_folder, 'public'

  get '/space/new' do
    erb(:"space/new")
  end

  post '/space/new' do
    space = Space.create(name: params[:name],
                         description: params[:description],
                         price: params[:price])
    redirect "/space/index"
  end

  get '/space/index' do
    erb(:"space/index")
  end

  # get '/request/new' do
  #   erb(:"request/new")
  # end
  #
  # post '/request/new' do
  #   Request.create(start_date: params[:start_date],
  #                  end_date: params[:end_date])
  #   redirect "/space/index"
  # end

  # start the server if ruby file executed directl

  get '/reservation' do
    File.read(File.join('public', 'calendar.html'))
  end

  post '/reservation' do
    Request.create(start_date: params[:start_date], end_date: params[:end_date], status: 1)
    p params[:start_date]
    p params[:end_date]
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

  run! if app_file == $0
end
