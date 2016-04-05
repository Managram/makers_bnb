require 'sinatra/base'

ENV['RACK_ENV'] ||= 'development'

require_relative 'models/data_mapper_setup'


class MakersBnb < Sinatra::Base

  get '/space/new' do
    erb(:"space/new")
  end

  post '/space/new' do
    Space.create(name: params[:name],
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


  # start the server if ruby file executed directly
  run! if app_file == $0
end
