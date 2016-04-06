class MakersBnb < Sinatra::Base

  get '/home' do
    erb :index
  end

	get '/user/new' do
    @user = User.new
    erb(:"user/new")
  end

  post '/user/new' do
    @user = User.new(name: params[:name],
                     email: params[:email],
                     username: params[:username],
                     password: params[:password],
                     password_confirmation: params[:password_confirmation])
    if @user.save
      session[:user_id] = @user.id
      redirect '/space/index'
    else
      flash.now[:errors] = @user.errors.full_messages
      erb(:"user/new")
    end
  end
  
end