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
    p "there"
    session[:searched_dates]
    @spaces = Space.all
    @searched_dates = session[:searched_dates]
    p "there too"
    erb(:"space/index")
  end

  post '/space/search' do
    session[:searched_dates] = get_date_range(js_to_rb_date(params[:start_date]), js_to_rb_date(params[:end_date]))
    p "here"
    # unavailable_dates = retrieve_bookings(Bookings.all)
    redirect "/space/index"
  end

  get '/space/:id/view' do
    @space = Space.first(id: params[:id])
    erb(:"/space/view")
  end
  
end