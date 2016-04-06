class MakersBnb < Sinatra::Base

	get '/space/new' do
    erb(:"space/new")
  end

  post '/space/new' do
    user = User.get(session[:user_id])
    user.spaces.create(name: params[:name],
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
  
end