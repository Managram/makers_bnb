class MakersBnb < Sinatra::Base

  get '/sessions/new' do
    erb(:'sessions/new')
  end

  post '/sessions' do
    user = User.authenticate(params[:email],
                             params[:password])
    if user
      session[:user_id] = user.id
      redirect "/space/index"
    else
      flash.now[:errors] = ["Incorrect email or password"]
      erb(:"sessions/new")
    end
  end

  delete '/sessions' do
    session[:user_id] = nil
		session[:searched_dates] = nil
    redirect '/home'
  end

end
