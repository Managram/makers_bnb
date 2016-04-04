require 'sinatra/base'

ENV['RACK_ENV'] ||= 'development'

require_relative 'models/data_mapper_setup'


class MakersBnb < Sinatra::Base

  get '/space/new' do
    erb(:"space/new")
  end

  post '/space/new' do
    space = Space.new(name: params[:name])
    space.save
    redirect "/space/index"
  end

  get '/space/index' do
    erb(:"space/index")
  end

  # start the server if ruby file executed directly
  run! if app_file == $0
end
