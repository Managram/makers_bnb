require_relative 'helpers'

class MakersBnb < Sinatra::Base
	enable :sessions
  set :session_secret, "super_secret"
  set :public_folder, 'public'

  use Rack::MethodOverride

  register Sinatra::Flash
	register Sinatra::Partial
	set :partial_template_engine, :erb
	enable :partial_underscores

  helpers Helpers

	run! if app_file == $0

end
