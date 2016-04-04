require 'sinatra/base'
require 'json'

class MakersBnb < Sinatra::Base
  # start the server if ruby file executed directly
  set :public_folder, 'public'

  get '/reservation' do
    File.read(File.join('public', 'calendar.html'))
  end

  post '/reservation' do
    p params[:start_date]
    p params[:end_date]
  end

  run! if app_file == $0
end
