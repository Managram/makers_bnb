require_relative 'helpers'

class MakersBnb < Sinatra::Base
	enable :sessions
  set :session_secret, "super_secret"
  set :public_folder, 'public'

  use Rack::MethodOverride

  register Sinatra::Flash

  helpers Helpers

	run! if app_file == $0	

end