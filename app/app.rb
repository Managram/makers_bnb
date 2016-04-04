require 'sinatra/base'

class MakersBnb < Sinatra::Base
  # start the server if ruby file executed directly
  set :public_folder, 'public'

  get '/' do 
  	send_file 'calendar.html'  	
  end

  run! if app_file == $0
end
