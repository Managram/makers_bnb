class MakersBnb < Sinatra::Base

  get '/space/new' do
    @this_space = Space.new
    erb(:"space/new")
  end

  post '/space/new' do
    user = User.get(session[:user_id])
    user.spaces.create(name:        params[:name],
                       description: params[:description],
                       price:       params[:price])
    redirect "/space/index"
  end

  get '/space/index' do
    @spaces = Space.all
    @searched_dates = session[:searched_dates]
    erb(:"space/index")
  end

  post '/space/search' do
    session[:searched_dates] = get_date_range(js_to_rb_date(params[:start_date]), js_to_rb_date(params[:end_date]))
    redirect "/space/index"
  end

  post '/space/reset-search' do
    session[:searched_dates] = nil
    redirect "/space/index"
  end

  get '/space/:id/view' do
    @space = Space.first(id: params[:id])
    erb(:"space/view")
  end

  get '/my-spaces' do
    @spaces = Space.all(user_id: current_user.id)
    erb(:"space/myspaces")
  end

  get '/my-spaces/:space_id' do
    @this_space = Space.first(id: params[:space_id])
    params[:space_id]
    erb(:"space/space")
  end

  post '/my-spaces/edit/:space_id' do
    space = Space.first(id: params[:space_id])
    space.update(name:        params[:name],
                 description: params[:description],
                 price:       params[:price])
    space.save
    if space.save
      flash.next[:notice] = ["Details updated"]
    end
    redirect "/my-spaces/#{space.id}"
  end

end
