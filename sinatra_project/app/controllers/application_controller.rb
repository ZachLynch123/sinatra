require './config/environment'

class ApplicationController < Sinatra::Base

  configure do
    set :public_folder, 'public'
    set :views, 'app/views'
    enable :sessions 
    set :session_secret, "secret_session"
  end

  get "/" do
    erb :index
  end

  get "/sign_up" do 
    erb :sign_up
  end

  post "/sign_up" do 
    @user = User.create(:username => params[:username], :password => params[:password])
    @session = session
    if @user.save 
      redirect '/login'
    else
      "Invalid username or password"
      redirect '/sign_up'
    end

  end


  get "/login" do 
    erb :login 
  end

  #separate the application controller into 2 different controllers, one for users, one for character

  post '/login' do 
    @user = User.find_by(:username => params[:username])
    if @user
      session["user"] = @user
      session["user_id"] = @user.id
      @session = session
      redirect "/users/#{@user.id}"
    else
      redirect '/login'
    end
  end
  


  post '/characters/new' do 
    @user = User.find_by
  end

  post '/characters' do 
    binding.pry
    @character_created = Character.create(
      :name => params[:name],
      :class => params[:class],
      :race => params[:race],
      :strength => params[:strength],
      :dexterity => params[:dexterity],
      :constitution => params[:constitution],
      :intelligence => params[:intelligence],
      :wisdom => params[:wisdom],
      :charisma => params[:charisma]
    )

    @character_created.user = @user
    @character_created.save 

    @character_created

  end





end
