require 'sinatra/base'

ENV['RACK_ENV'] ||= 'development'

require_relative 'models/data_mapper_setup'


class MakersBnb < Sinatra::Base

  get '/space/new' do
    erb(:"space/new")
  end

  post '/space/new' do
    @space = Space.create(name: params[:name],
                         description: params[:description],
                         price: params[:price])
    redirect "/space/index"
  end

  get '/space/index' do
    @spaces = Space.all#(name: params[:name],
    #                     #  description: params[:description],
    #                     #  price: params[:price])
    erb(:"space/index")
  end

  post '/space/:name/view' do
    @spaceinfo = Space.get(name: params[:name])
    p @spaceinfo
    redirect "/space/view"
  end

  get '/space/view' do
    @space = @spaceinfo
    erb(:"/space/view")
  end


  # start the server if ruby file executed directly
  run! if app_file == $0
end
