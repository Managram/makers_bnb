ENV['RACK_ENV'] ||= 'development'

require 'sinatra/base'
require 'json'
require_relative 'booking.rb'

ENV['RACK_ENV'] ||= 'development'

require_relative 'models/data_mapper_setup'


class MakersBnb < Sinatra::Base

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

  get '/request/new' do
    erb(:"request/new")
  end

  post '/request/new' do
    Request.create(start_date: params[:start_date],
                   end_date: params[:end_date])
    redirect "/space/index"
  end

  # start the server if ruby file executed directly
  set :public_folder, 'public'

  get '/reservation' do
    File.read(File.join('public', 'calendar.html'))
  end

  post '/reservation' do
    Booking.create(start_date: params[:start_date], end_date: params[:end_date])
    p params[:start_date]
    p params[:end_date]
  end

  run! if app_file == $0
end
